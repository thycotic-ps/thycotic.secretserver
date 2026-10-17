function Set-TssProxyEndpointSite {
    <#
    .SYNOPSIS
    Set the SSH proxy, RDP proxy and RDP gateway settings of a site

    .DESCRIPTION
    Updates the proxy endpoint of a distributed engine site. Only the parameters provided are changed.
    The API clears the site RDP proxy certificate secret when the request omits it, so this command reads the current value first and sends it back unless -RdpProxyCertificateSecretId is provided.
    A site port only applies when the matching Inherited flag is false.
    Returns the proxy endpoint summary after the change.
    Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Site ID (SiteId in Search-TssProxyEndpoint output)

    .PARAMETER EnableSshProxy
    Enable or disable the SSH proxy for the site

    .PARAMETER SshProxyPort
    SSH proxy port for the site

    .PARAMETER SshProxyPortInherited
    Use the global SSH proxy port. Pass -SshProxyPortInherited:$false with -SshProxyPort to set a site port

    .PARAMETER SshJumpboxAvailablePortRange
    Port range available for SSH jumpbox port forwarding, for example 5000-5100

    .PARAMETER EnableRdpProxy
    Enable or disable the RDP proxy for the site

    .PARAMETER RdpProxyPort
    RDP proxy port for the site

    .PARAMETER RdpProxyPortInherited
    Use the global RDP proxy port. Pass -RdpProxyPortInherited:$false with -RdpProxyPort to set a site port

    .PARAMETER EnableRdpGateway
    Enable or disable the RDP gateway for the site

    .PARAMETER RdpGatewayPort
    RDP gateway port for the site (1-65535)

    .PARAMETER RdpGatewayPortInherited
    Use the global RDP gateway port. Pass -RdpGatewayPortInherited:$false with -RdpGatewayPort to set a site port

    .PARAMETER RdpProxyCertificateSecretId
    ID of the secret holding the RDP proxy certificate for the site. Pass 0 to clear it. When omitted, the current certificate secret is kept

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxyEndpointSite -TssSession $session -Id 3 -EnableSshProxy -SshProxyPort 2222 -SshProxyPortInherited:$false

    Enables the SSH proxy on site 3 with its own port 2222

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxyEndpointSite -TssSession $session -Id 3 -EnableRdpProxy:$false

    Turns the RDP proxy off for site 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointSite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    The local (web) site cannot be changed with this command: the API denies it.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.Endpoint')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SiteId')]
        [int]
        $Id,

        [switch]
        $EnableSshProxy,

        [int]
        $SshProxyPort,

        [switch]
        $SshProxyPortInherited,

        [string]
        $SshJumpboxAvailablePortRange,

        [switch]
        $EnableRdpProxy,

        [int]
        $RdpProxyPort,

        [switch]
        $RdpProxyPortInherited,

        [switch]
        $EnableRdpGateway,

        [int]
        $RdpGatewayPort,

        [switch]
        $RdpGatewayPortInherited,

        [int]
        $RdpProxyCertificateSecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'endpoints', 'sites', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            $body.Add('siteId', $Id)
            if (-not $tssParams.ContainsKey('RdpProxyCertificateSecretId')) {
                $currentSite = (Search-TssProxyEndpoint -TssSession $TssSession).Sites | Where-Object SiteId -EQ $Id
                if (-not $currentSite) {
                    Write-Error "Site $Id was not found in the proxy endpoints"
                    return
                }
                $body.Add('rdpProxyCertificateSecretId', $currentSite.RdpProxyCertificateSecretId)
            }
            switch ($tssParams.Keys) {
                'EnableSshProxy' {
                    $body.Add('enableSshProxy', [boolean]$EnableSshProxy)
                }
                'SshProxyPort' {
                    $body.Add('sshProxyPort', $SshProxyPort)
                }
                'SshProxyPortInherited' {
                    $body.Add('sshProxyPortInherited', [boolean]$SshProxyPortInherited)
                }
                'SshJumpboxAvailablePortRange' {
                    $body.Add('sshJumpboxAvailablePortRange', $SshJumpboxAvailablePortRange)
                }
                'EnableRdpProxy' {
                    $body.Add('enableRdpProxy', [boolean]$EnableRdpProxy)
                }
                'RdpProxyPort' {
                    $body.Add('rdpProxyPort', $RdpProxyPort)
                }
                'RdpProxyPortInherited' {
                    $body.Add('rdpProxyPortInherited', [boolean]$RdpProxyPortInherited)
                }
                'EnableRdpGateway' {
                    $body.Add('enableRdpGateway', [boolean]$EnableRdpGateway)
                }
                'RdpGatewayPort' {
                    $body.Add('rdpGatewayPort', $RdpGatewayPort)
                }
                'RdpGatewayPortInherited' {
                    $body.Add('rdpGatewayPortInherited', [boolean]$RdpGatewayPortInherited)
                }
                'RdpProxyCertificateSecretId' {
                    if ($RdpProxyCertificateSecretId -eq 0) {
                        $body.Add('rdpProxyCertificateSecretId', $null)
                    } else {
                        $body.Add('rdpProxyCertificateSecretId', $RdpProxyCertificateSecretId)
                    }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy endpoint site: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxyEndpointSite request'
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
