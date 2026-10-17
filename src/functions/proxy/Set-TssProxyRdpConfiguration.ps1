function Set-TssProxyRdpConfiguration {
    <#
    .SYNOPSIS
    Set the RDP proxy configuration

    .DESCRIPTION
    Updates the RDP proxy configuration. Only the parameters provided are changed.
    Use -CertificatePath to upload a PFX certificate for the RDP proxy, with -CertificatePassword when the file is protected.
    Returns the RDP proxy configuration after the change.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnableRdpProxy
    Enable or disable the RDP proxy

    .PARAMETER RdpProxyPort
    Port the RDP proxy listens on (1-65535)

    .PARAMETER EnableRemoteHostValidation
    Enforce certificate validation on the remote hosts the proxy connects to

    .PARAMETER AllowSiteSelectionForActiveDirectoryAccounts
    Allow users to pick a site when launching or generating proxy credentials for an RDP proxied secret

    .PARAMETER DaysToKeepOperationalLogs
    Number of days to keep RDP proxy logs (1 or more)

    .PARAMETER SspiAuthenticationMethod
    Authentication method for SSPI connections

    .PARAMETER ProxyNewSecretsByDefault
    Create new RDP secrets with proxying enabled

    .PARAMETER EnableRdpGateway
    Enable or disable the RDP gateway

    .PARAMETER RdpGatewayPort
    Port the RDP gateway listens on (1-65535)

    .PARAMETER CertificatePath
    Path to a PFX file to upload as the RDP proxy server certificate

    .PARAMETER CertificatePassword
    Password of the PFX file given in CertificatePath

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxyRdpConfiguration -TssSession $session -EnableRdpProxy -RdpProxyPort 4489 | Out-Null

    Enables the RDP proxy on port 4489

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $pfxPassword = Read-Host -AsSecureString -Prompt 'PFX password'
    Set-TssProxyRdpConfiguration -TssSession $session -CertificatePath ./rdp-proxy.pfx -CertificatePassword $pfxPassword | Out-Null

    Uploads a PFX certificate for the RDP proxy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyRdpConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyRdpConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.RdpConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnableRdpProxy,

        [int]
        $RdpProxyPort,

        [switch]
        $EnableRemoteHostValidation,

        [switch]
        $AllowSiteSelectionForActiveDirectoryAccounts,

        [int]
        $DaysToKeepOperationalLogs,

        [ValidateSet('Negotiate', 'Kerberos', 'Ntlm')]
        [string]
        $SspiAuthenticationMethod,

        [switch]
        $ProxyNewSecretsByDefault,

        [switch]
        $EnableRdpGateway,

        [int]
        $RdpGatewayPort,

        [Parameter(Mandatory, ParameterSetName = 'Certificate')]
        [string]
        $CertificatePath,

        [Parameter(ParameterSetName = 'Certificate')]
        [securestring]
        $CertificatePassword
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
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            switch ($tssParams.Keys) {
                'EnableRdpProxy' {
                    $body.Add('enableRdpProxy', [boolean]$EnableRdpProxy)
                }
                'RdpProxyPort' {
                    $body.Add('rdpProxyPort', $RdpProxyPort)
                }
                'EnableRemoteHostValidation' {
                    $body.Add('enableRemoteHostValidation', [boolean]$EnableRemoteHostValidation)
                }
                'AllowSiteSelectionForActiveDirectoryAccounts' {
                    $body.Add('allowSiteSelectionForActiveDirectoryAccounts', [boolean]$AllowSiteSelectionForActiveDirectoryAccounts)
                }
                'DaysToKeepOperationalLogs' {
                    $body.Add('daysToKeepOperationalLogs', $DaysToKeepOperationalLogs)
                }
                'SspiAuthenticationMethod' {
                    $body.Add('sspiAuthenticationMethod', $SspiAuthenticationMethod)
                }
                'ProxyNewSecretsByDefault' {
                    $body.Add('proxyNewSecretsByDefault', [boolean]$ProxyNewSecretsByDefault)
                }
                'EnableRdpGateway' {
                    $body.Add('enableRdpGateway', [boolean]$EnableRdpGateway)
                }
                'RdpGatewayPort' {
                    $body.Add('rdpGatewayPort', $RdpGatewayPort)
                }
                'CertificatePath' {
                    $certificate = @{
                        rdpServerCertificate         = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $CertificatePath).ProviderPath))
                        rdpServerCertificateFileName = Split-Path -Path $CertificatePath -Leaf
                    }
                    if ($tssParams.ContainsKey('CertificatePassword')) {
                        $certificate.Add('rdpServerCertificatePassword', [System.Net.NetworkCredential]::new('', $CertificatePassword).Password)
                    }
                    $body.Add('rdpServerCertificate', $certificate)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $bodyText = if ($PSCmdlet.ParameterSetName -eq 'Certificate') { ' (request body not shown: it carries the certificate)' } else { " with:`n$($invokeParams.Body)`n" }
            if ($PSCmdlet.ShouldProcess("Proxy rdp configuration", "$($invokeParams.Method) $uri$bodyText")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri$bodyText"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxyRdpConfiguration request'
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
