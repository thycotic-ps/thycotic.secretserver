function Set-TssConfigurationSaml {
    <#
    .SYNOPSIS
    Set the global SAML configuration

    .DESCRIPTION
    Updates the global SAML settings and returns the SAML configuration. Only the parameters you pass are changed.
    Identity providers are managed with Get-TssSamlIdentityProvider, Add-TssSamlIdentityProviderCertificate and Remove-TssSamlIdentityProviderCertificate.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    Enable SAML authentication. Use -Enabled:$false to disable it

    .PARAMETER DisableAutoRedirect
    Do not send users to the identity provider login page automatically

    .PARAMETER UseLegacy
    Use the legacy SAML implementation

    .PARAMETER EnableLegacySLO
    Enable single logout for the legacy SAML implementation

    .PARAMETER LegacyUsernameAttribute
    SAML attribute used as the username by the legacy implementation

    .PARAMETER ServiceProviderName
    Service provider name. It cannot be cleared once set

    .PARAMETER ServiceProviderCertificate
    Base64-encoded service provider certificate (PFX)

    .PARAMETER ServiceProviderCertificatePassword
    Password of the service provider certificate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationSaml -TssSession $session -Enabled -ServiceProviderName 'Secret Server'

    Enables SAML and sets the service provider name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationSaml -TssSession $session -DisableAutoRedirect:$false

    Sends users to the identity provider login page automatically

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationSaml

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationSaml.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.Saml')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Enabled,

        [switch]
        $DisableAutoRedirect,

        [switch]
        $UseLegacy,

        [switch]
        $EnableLegacySLO,

        [string]
        $LegacyUsernameAttribute,

        [string]
        $ServiceProviderName,

        [string]
        $ServiceProviderCertificate,

        [securestring]
        $ServiceProviderCertificatePassword
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'saml' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'DisableAutoRedirect' {
                    $body.data.Add('disableAutoRedirect', @{ dirty = $true; value = [boolean]$DisableAutoRedirect })
                }
                'UseLegacy' {
                    $body.data.Add('useLegacy', @{ dirty = $true; value = [boolean]$UseLegacy })
                }
                'EnableLegacySLO' {
                    $body.data.Add('enableLegacySLO', @{ dirty = $true; value = [boolean]$EnableLegacySLO })
                }
                'LegacyUsernameAttribute' {
                    $body.data.Add('legacyUsernameAttribute', @{ dirty = $true; value = $LegacyUsernameAttribute })
                }
                'ServiceProviderName' {
                    $body.data.Add('serviceProviderName', @{ dirty = $true; value = $ServiceProviderName })
                }
                'ServiceProviderCertificate' {
                    $body.data.Add('serviceProviderCertificate', @{ dirty = $true; value = $ServiceProviderCertificate })
                }
                'ServiceProviderCertificatePassword' {
                    $body.data.Add('serviceProviderCertificatePassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $ServiceProviderCertificatePassword).Password })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration saml", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationSaml request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.Saml](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.Saml]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
