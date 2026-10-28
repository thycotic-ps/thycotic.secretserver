function Set-TssProxyEndpointEngine {
    <#
    .SYNOPSIS
    Set the proxy public host or bind address of a distributed engine

    .DESCRIPTION
    Updates the proxy endpoint of a distributed engine. Only the parameters provided are changed.
    Returns the proxy endpoint summary after the change.
    Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Distributed engine ID (EngineId in Search-TssProxyEndpoint output)

    .PARAMETER PublicHost
    Host name or address that clients use to reach the proxy on this engine

    .PARAMETER BindIpAddress
    IP address the proxy listens on for this engine

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxyEndpointEngine -TssSession $session -Id 3 -PublicHost proxy.example.com

    Sets the public host clients use to reach the proxy on engine 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.Endpoint')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EngineId')]
        [int]
        $Id,

        [string]
        $PublicHost,

        [string]
        $BindIpAddress
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'endpoints', 'engines', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            $body.Add('engineId', $Id)
            switch ($tssParams.Keys) {
                'PublicHost' {
                    $body.Add('publicHost', $PublicHost)
                }
                'BindIpAddress' {
                    $body.Add('bindIpAddress', $BindIpAddress)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy endpoint engine: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxyEndpointEngine request'
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
