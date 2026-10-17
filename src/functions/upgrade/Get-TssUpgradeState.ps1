function Get-TssUpgradeState {
    <#
    .SYNOPSIS
    Get the upgrade state

    .DESCRIPTION
    Returns the readiness of an automatic upgrade: installed version, latest version available to download, whether a staged version can be installed, read-only mode capability, database name and server, and application pool disk access.
    Makes no changes.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUpgradeState -TssSession $session

    Returns the upgrade state

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUpgradeState -TssSession $session | Select-Object CurrentVersion, LatestVersionToDownload, CanInstallDownloadedVersion

    Shows the installed version, the latest version available and whether a staged version can be installed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Upgrade.State')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUpgradeState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Upgrade.State](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.State]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
