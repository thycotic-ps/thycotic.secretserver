function Start-TssUpgrade {
    <#
    .SYNOPSIS
    Install a staged Secret Server upgrade and wait for it to finish

    .DESCRIPTION
    Runs an upgrade end to end and makes several calls: Get-TssUpgradeState for the starting version, Start-TssUpgradeDownload when -Download is set, Install-TssUpgrade, then Get-TssUpgradeStatus and Get-TssUpgradeState every -PollSeconds until the run ends, the version reaches -ExpectedVersion, or -TimeoutMinutes passes.
    The package must already be staged (Start-TssUpgradeDownload or an upload through the web UI) unless -Download is set. -EnableReadOnlyMode turns read-only mode on before the install and off after it (PATCH configuration/read-only-mode).
    The web application recycles during the upgrade, so some polls get no answer. That is expected: -Verbose shows each poll. The session token must stay valid for the whole run; if it expires, check the outcome with Get-TssUpgradeStatus and a new session.
    Returns the starting and final version, the last upgrade status, and whether the upgrade succeeded. A failed or timed out upgrade also writes an error.
    An upgrade cannot be undone. Back up the database first.
    Requires the Administer Configuration permission. -EnableReadOnlyMode also needs the Administer Maintenance Mode permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Download
    Download and stage the latest upgrade from the Delinea update server first (Start-TssUpgradeDownload)

    .PARAMETER EarlyAdopter
    With -Download, download early adopter (pre-release) versions instead of generally available ones

    .PARAMETER ExpectedVersion
    Version the server must run when the upgrade is done, for example 12.3.000024. Without it, success means the run ended successfully on a new version

    .PARAMETER EnableReadOnlyMode
    Turn read-only mode on before the install and off after it. The upgrade is not started when read-only mode cannot be turned on, and read-only mode stays on when the upgrade does not finish within -TimeoutMinutes

    .PARAMETER ImpersonationCredential
    Windows account the server impersonates for disk access when the application pool identity lacks it

    .PARAMETER TimeoutMinutes
    Minutes to wait for the upgrade to finish, 20 by default

    .PARAMETER PollSeconds
    Seconds between progress checks, 10 by default

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssUpgrade -TssSession $session -ExpectedVersion 12.3.000024

    Installs the staged upgrade after asking for confirmation and waits until the server runs version 12.3.000024

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssUpgrade -TssSession $session -Download -EnableReadOnlyMode -TimeoutMinutes 40 -Confirm:$false

    Downloads the latest upgrade, installs it in read-only mode without a confirmation prompt, and waits up to 40 minutes

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgrade

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgrade.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Upgrade.Result')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Download,

        [switch]
        $EarlyAdopter,

        [string]
        $ExpectedVersion,

        [switch]
        $EnableReadOnlyMode,

        [pscredential]
        $ImpersonationCredential,

        [ValidateRange(1, 1440)]
        [int]
        $TimeoutMinutes = 20,

        [ValidateRange(1, 3600)]
        [int]
        $PollSeconds = 10
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'read-only-mode' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $setReadOnlyMode = {
                param([bool]$Enabled)
                $restResponse = $null
                $invokeParams.Body = @{ data = @{ enabled = @{ dirty = $true; value = $Enabled } } } | ConvertTo-Json -Depth 100
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssUpgrade request'
                    $err = $_
                    . $ErrorHandling $err
                }
                $null -ne $restResponse
            }
            $credentialParams = @{ }
            if ($tssParams.ContainsKey('ImpersonationCredential')) {
                $credentialParams.ImpersonationCredential = $ImpersonationCredential
            }
            if ($PSCmdlet.ShouldProcess("$($TssSession.SecretServer)", 'Install the staged Secret Server upgrade and wait for it to finish')) {
                $stopwatch = [Diagnostics.Stopwatch]::StartNew()
                $state = Get-TssUpgradeState -TssSession $TssSession
                if (-not $state) {
                    return
                }
                $result = [Thycotic.PowerShell.Upgrade.Result]@{
                    StartVersion    = $state.CurrentVersion
                    ExpectedVersion = $ExpectedVersion
                }
                if ($Download) {
                    $downloadResult = Start-TssUpgradeDownload -TssSession $TssSession -EarlyAdopter:$EarlyAdopter @credentialParams -Confirm:$false
                    if (-not $downloadResult.Success) {
                        Write-Error "Upgrade download failed: $($downloadResult.StatusMessage)"
                        return
                    }
                    $state = Get-TssUpgradeState -TssSession $TssSession
                }
                if (-not $state.CanInstallDownloadedVersion) {
                    Write-Error "No upgrade can be installed on [$($TssSession.SecretServer)]: stage one with Start-TssUpgradeDownload or the web UI first. $($state.DenyInstallMessage)"
                    return
                }
                if ($EnableReadOnlyMode -and -not (& $setReadOnlyMode $true)) {
                    Write-Error 'Read-only mode could not be turned on, so the upgrade was not started'
                    return
                }
                $installResult = Install-TssUpgrade -TssSession $TssSession @credentialParams -Confirm:$false
                $finished = $false
                if ($installResult.UpgradeStartSuccess) {
                    $deadline = (Get-Date).AddMinutes($TimeoutMinutes)
                    $sawRunning = $false
                    while (-not $finished -and (Get-Date) -lt $deadline) {
                        Start-Sleep -Seconds $PollSeconds
                        $progress = Get-TssUpgradeStatus -TssSession $TssSession -ErrorAction SilentlyContinue -ErrorVariable pollError -WarningAction SilentlyContinue
                        $currentVersion = (Get-TssUpgradeState -TssSession $TssSession -ErrorAction SilentlyContinue -ErrorVariable +pollError -WarningAction SilentlyContinue).CurrentVersion
                        Write-Verbose "Upgrade poll: version [$currentVersion], running [$($progress.Status.isRunning)], success [$($progress.Status.isSuccess)], errors [$($pollError -join '; ')]"
                        if ($progress) {
                            $result.Status = $progress.Status
                            if ($progress.Status.isRunning) {
                                $sawRunning = $true
                            }
                        }
                        if ($currentVersion) {
                            $result.FinalVersion = $currentVersion
                        }
                        $versionChanged = $currentVersion -and $currentVersion -ne $result.StartVersion
                        $runFailed = $progress.Status.isSuccess -eq $false -and -not $progress.HasOtherNodes
                        $runEnded = $progress -and -not $progress.Status.isRunning -and ($sawRunning -or $versionChanged -or $runFailed)
                        $finished = $runEnded -or ($ExpectedVersion -and $currentVersion -eq $ExpectedVersion)
                    }
                } else {
                    Write-Error "Upgrade install did not start: $($installResult.ErrorMessage)"
                }
                if ($EnableReadOnlyMode -and $installResult.UpgradeStartSuccess -and -not $finished) {
                    Write-Warning 'Read-only mode is still on because the upgrade did not finish. Turn it off once the upgrade completes.'
                } elseif ($EnableReadOnlyMode) {
                    $null = & $setReadOnlyMode $false
                }
                if ($ExpectedVersion) {
                    $result.Success = $result.FinalVersion -eq $ExpectedVersion
                } else {
                    $result.Success = [bool]($result.FinalVersion -and $result.FinalVersion -ne $result.StartVersion -and $result.Status.isSuccess)
                }
                if ($installResult.UpgradeStartSuccess -and -not $finished) {
                    Write-Error "Upgrade did not finish within $TimeoutMinutes minutes (version [$($result.FinalVersion)])"
                } elseif ($installResult.UpgradeStartSuccess -and -not $result.Success) {
                    Write-Error "Upgrade ended without success (version [$($result.FinalVersion)]): $($result.Status.exceptionMessage)"
                }
                $result.ElapsedSeconds = [int]$stopwatch.Elapsed.TotalSeconds
                $result
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
