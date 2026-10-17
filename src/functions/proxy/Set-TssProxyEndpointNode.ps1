function Set-TssProxyEndpointNode {
    <#
    .SYNOPSIS
    Set the proxy public host, bind address or jumpbox port range of a web node

    .DESCRIPTION
    Updates the proxy endpoint of a Secret Server web node. Only the parameters provided are changed.
    Returns the proxy endpoint summary after the change.
    Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Web node ID (NodeId in Search-TssProxyEndpoint output)

    .PARAMETER PublicHost
    Host name or address that clients use to reach the proxy on this node

    .PARAMETER BindIpAddress
    IP address the proxy listens on for this node

    .PARAMETER JumpboxAvailablePortRange
    Port range available on this node for SSH jumpbox port forwarding, for example 5000-5100

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxyEndpointNode -TssSession $session -Id 1 -BindIpAddress 10.0.0.15

    Sets the bind address of the proxy on node 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointNode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointNode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    On-premises only: Secret Server Cloud has no web nodes to configure.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.Endpoint')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('NodeId')]
        [int]
        $Id,

        [string]
        $PublicHost,

        [string]
        $BindIpAddress,

        [string]
        $JumpboxAvailablePortRange
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'endpoints', 'nodes', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            $body.Add('nodeId', $Id)
            switch ($tssParams.Keys) {
                'PublicHost' {
                    $body.Add('publicHost', $PublicHost)
                }
                'BindIpAddress' {
                    $body.Add('bindIpAddress', $BindIpAddress)
                }
                'JumpboxAvailablePortRange' {
                    $body.Add('jumpboxAvailablePortRange', $JumpboxAvailablePortRange)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy endpoint node: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxyEndpointNode request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Proxy.Endpoint](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.Endpoint]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
