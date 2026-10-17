function New-TssProxyRdpCertificate {
    <#
    .SYNOPSIS
    Generate a new RDP proxy server certificate

    .DESCRIPTION
    Generates a new self-signed RDP proxy server certificate for the DNS name provided, replaces the current certificate, and returns the RDP proxy configuration.
    RDP clients that pinned the previous certificate see a certificate warning on their next connection.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
     RdpServerCertificate carries the new certificate including its private key.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DnsName
    DNS name used as the subject of the new self-signed certificate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssProxyRdpCertificate -TssSession $session -DnsName rdp.example.com | Out-Null

    Replaces the RDP proxy certificate with a new one for rdp.example.com, without returning it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxyRdpCertificate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxyRdpCertificate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.RdpConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $DnsName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'rdp', 'generate-certificate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'DnsName' {
                    $body.Add('dnsName', $DnsName)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy rdp certificate", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssProxyRdpCertificate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Proxy.RdpConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.RdpConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
