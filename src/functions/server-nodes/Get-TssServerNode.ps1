function Get-TssServerNode {
    <#
    .SYNOPSIS
    Get a Secret Server web node

    .DESCRIPTION
    Gets one or more Secret Server web nodes by ID: machine name, version, cluster membership, enabled worker roles and their errors, read-only mode and log level.
    Search-TssServerNode lists every node.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Server node ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerNode -TssSession $session -Id 2

    Gets server node 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssServerNode -TssSession $session | Get-TssServerNode -TssSession $session | Where-Object EngineWorkerError

    Gets every node and shows those reporting an engine worker error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ServerNodes.Node')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('NodeId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'nodes', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssServerNode request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ServerNodes.Node](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ServerNodes.Node]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
