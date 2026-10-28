function Get-TssProxyRdpConfiguration {
    <#
    .SYNOPSIS
    Get the RDP proxy configuration

    .DESCRIPTION
    Returns the RDP proxy configuration: proxy and gateway enablement and ports, remote host validation, SSPI authentication method, log retention and the RDP server certificate.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
     RdpServerCertificate carries the RDP proxy server certificate as stored, including its private key.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssProxyRdpConfiguration -TssSession $session | Select-Object EnableRdpProxy, RdpProxyPort

    Returns whether the RDP proxy is enabled and its port

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyRdpConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyRdpConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.RdpConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'rdp', 'config' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssProxyRdpConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.RdpConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.RdpConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
