function Search-TssProxyEndpoint {
    <#
    .SYNOPSIS
    Get the proxy endpoints of every site, engine and node

    .DESCRIPTION
    Returns one object with the global SSH proxy, RDP proxy and RDP gateway settings plus the proxy configuration of each site (Sites), distributed engine (Engines) and web node (Nodes).
    Use the SiteId, EngineId or NodeId of an entry with Set-TssProxyEndpointSite, Set-TssProxyEndpointEngine or Set-TssProxyEndpointNode.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssProxyEndpoint -TssSession $session

    Returns the proxy endpoint summary

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Search-TssProxyEndpoint -TssSession $session).Sites

    Lists the proxy settings of each site

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxyEndpoint

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxyEndpoint.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.Endpoint')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'endpoints' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssProxyEndpoint request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.Endpoint](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.Endpoint]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
