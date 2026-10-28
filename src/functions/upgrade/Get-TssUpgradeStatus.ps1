function Get-TssUpgradeStatus {
    <#
    .SYNOPSIS
    Get the progress of the most recent upgrade

    .DESCRIPTION
    Returns the progress of the most recent upgrade (or initial install) run. Status holds the start and end, whether it is still running, whether it succeeded, any exception, and the per-task breakdown.
    Also reports whether the instance has other nodes and whether read-only mode is enabled.
    Makes no changes.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUpgradeStatus -TssSession $session

    Returns the progress of the most recent upgrade

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssUpgradeStatus -TssSession $session).Status.tasks | Select-Object displayName, success

    Lists each task of the most recent upgrade and whether it succeeded

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Upgrade.UpgradeStatus')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'upgrade-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUpgradeStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Upgrade.UpgradeStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.UpgradeStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
