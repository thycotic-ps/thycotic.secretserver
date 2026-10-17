function New-TssProxySshKey {
    <#
    .SYNOPSIS
    Generate a new SSH proxy host key

    .DESCRIPTION
    Generates a new SSH proxy host key, replaces the current key, and returns the SSH proxy configuration with the new key and fingerprint.
    SSH clients that stored the previous host key in known_hosts must update it before they reconnect.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected. SshHostKey is the SSH proxy host private key in PEM form.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Algorithm
    Key algorithm. The server uses ECDSA when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (New-TssProxySshKey -TssSession $session -Algorithm RSA).SshProxyHostFingerprint

    Replaces the SSH proxy host key with a new RSA key and returns the new fingerprint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshKey

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshKey.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.SshConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('ECDSA', 'RSA')]
        [string]
        $Algorithm
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'generate-key' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Algorithm' {
                    $body.Add('algorithm', $Algorithm)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy ssh key", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssProxySshKey request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Proxy.SshConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.SshConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
