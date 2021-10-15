function Search-TssServerNode {
    <#
    .SYNOPSIS
    Return list of Server Nodes for Secret Server

    .DESCRIPTION
    Return list of Server Nodes for Secret Server

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Search-TssServerNode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Search-TssServerNode.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssServerNode -TssSession $session -

    Returns list of all Server Nodes

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ServerNodes.List')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'nodes' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.Count -le 0 -and $restResponse.Length -eq 0) {
                Write-Warning "No records found"
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ServerNodes.List[]]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}