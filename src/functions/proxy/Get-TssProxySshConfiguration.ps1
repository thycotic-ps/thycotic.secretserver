function Get-TssProxySshConfiguration {
    <#
    .SYNOPSIS
    Get the SSH proxy configuration

    .DESCRIPTION
    Returns the SSH proxy and SSH terminal configuration: enablement, ports, tunneling, banners, inactivity timeouts, password hiding, block listing, jumpbox port range and log retention.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected. SshHostKey is the SSH proxy host private key in PEM form.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssProxySshConfiguration -TssSession $session | Select-Object EnableSshProxy, SshProxyPort, EnableSshTerminal

    Returns whether the SSH proxy and terminal are enabled, without the host key

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.SshConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'config' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssProxySshConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.SshConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.SshConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
