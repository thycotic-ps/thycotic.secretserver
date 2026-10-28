function Get-TssManualUpgradeState {
    <#
    .SYNOPSIS
    Get the manual upgrade state

    .DESCRIPTION
    Returns the readiness of a manual (multi-step) upgrade: installed version, staged patch, read-only mode and version mismatch flags, application pool disk access, file locations, and the progress of each manual step.
    Makes no changes.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssManualUpgradeState -TssSession $session

    Returns the manual upgrade state

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssManualUpgradeState -TssSession $session | Select-Object CurrentVersion, IsSqlScriptGenerated, AreSqlDeltasVerified, IsApplicationZipFileDownloaded

    Shows which manual upgrade steps are done

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssManualUpgradeState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssManualUpgradeState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Upgrade.ManualUpgradeState')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssManualUpgradeState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Upgrade.ManualUpgradeState](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.ManualUpgradeState]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
