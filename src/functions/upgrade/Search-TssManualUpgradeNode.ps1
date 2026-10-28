function Search-TssManualUpgradeNode {
    <#
    .SYNOPSIS
    List the nodes of a manual upgrade

    .DESCRIPTION
    Returns each node the manual (multi-step) upgrade tracks: installed version, last polled time, cluster membership, read-only mode, any error, and whether it is the node that answered the request.
    Use it to confirm every node reached the target version before Complete-TssManualUpgrade.
    Makes no changes.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssManualUpgradeNode -TssSession $session

    Lists the nodes of the manual upgrade

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssManualUpgradeNode -TssSession $session | Where-Object Version -NE '12.3.000024'

    Lists the nodes not yet on version 12.3.000024

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Search-TssManualUpgradeNode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Search-TssManualUpgradeNode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Upgrade.ManualUpgradeNode[]')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'nodes' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssManualUpgradeNode request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.nodes) {
                [Thycotic.PowerShell.Upgrade.ManualUpgradeNode[]](. $FilterTssResponse $restResponse.nodes ([Thycotic.PowerShell.Upgrade.ManualUpgradeNode]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
