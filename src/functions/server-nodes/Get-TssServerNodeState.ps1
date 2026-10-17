function Get-TssServerNodeState {
    <#
    .SYNOPSIS
    Get the clustering and SQL Server replication state

    .DESCRIPTION
    Gets whether clustering is enabled, whether SQL Server replication is enabled and whether the license allows SQL Server replication.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerNodeState -TssSession $session

    Gets the clustering and replication state

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ServerNodes.State')]
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
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'nodes-state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssServerNodeState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ServerNodes.State](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ServerNodes.State]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
