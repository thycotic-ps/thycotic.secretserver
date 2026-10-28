function Install-TssUpgrade {
    <#
    .SYNOPSIS
    Install a staged Secret Server upgrade

    .DESCRIPTION
    Starts the install of the upgrade package staged by Start-TssUpgradeDownload or uploaded through the web UI.
    The upgrade runs in the background on the server and this call returns once it has started: UpgradeStartSuccess is true when it started. A missing or broken staged package fails later, in the background run, so poll Get-TssUpgradeStatus.
    An upgrade cannot be undone. Back up the database first.
    When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can. A failed logon returns LoginFail true.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ImpersonationCredential
    Windows account the server impersonates for disk access when the application pool identity lacks it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Install-TssUpgrade -TssSession $session

    Starts the install of the staged upgrade after asking for confirmation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $appPoolCred = Get-Credential
    Install-TssUpgrade -TssSession $session -ImpersonationCredential $appPoolCred -Confirm:$false

    Starts the install as a Windows account that can write to the application folder, without a confirmation prompt

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Install-TssUpgrade

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Install-TssUpgrade.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Upgrade.Install')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [pscredential]
        $ImpersonationCredential
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'upgrade', 'install' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            if ($tssParams.ContainsKey('ImpersonationCredential')) {
                $body.data.Add('impersonationUserName', $ImpersonationCredential.UserName)
                $body.data.Add('impersonationPassword', $ImpersonationCredential.GetNetworkCredential().Password)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Upgrade", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Install-TssUpgrade request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Upgrade.Install](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.Install]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
