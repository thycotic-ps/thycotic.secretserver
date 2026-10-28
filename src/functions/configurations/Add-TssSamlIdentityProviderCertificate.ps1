function Add-TssSamlIdentityProviderCertificate {
    <#
    .SYNOPSIS
    Add a certificate to a SAML identity provider

    .DESCRIPTION
    Uploads a public certificate for a SAML identity provider and returns the new certificate entry.
    Secret Server uses the certificate to validate SAML messages signed by that provider.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IdentityProviderId
    SAML identity provider ID

    .PARAMETER CertificateData
    Base64-encoded public certificate of the identity provider

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $certificate = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes('./idp-signing.cer'))
    Add-TssSamlIdentityProviderCertificate -TssSession $session -IdentityProviderId 2 -CertificateData $certificate

    Adds the certificate in idp-signing.cer to SAML identity provider 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Add-TssSamlIdentityProviderCertificate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Add-TssSamlIdentityProviderCertificate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.SamlIdentityProviderCertificate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $IdentityProviderId,

        [Parameter(Mandatory)]
        [string]
        $CertificateData
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'saml', 'identity-provider', $IdentityProviderId, 'certificate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            $body.data.Add('identityProviderId', $IdentityProviderId)
            switch ($tssParams.Keys) {
                'CertificateData' {
                    $body.data.Add('certificateData', $CertificateData)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Saml identity provider certificate: $IdentityProviderId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssSamlIdentityProviderCertificate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SamlIdentityProviderCertificate](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SamlIdentityProviderCertificate]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
