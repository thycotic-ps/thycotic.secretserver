function Remove-TssSamlIdentityProviderCertificate {
    <#
    .SYNOPSIS
    Remove a certificate from a SAML identity provider

    .DESCRIPTION
    Deletes a certificate of a SAML identity provider. Returns True when Secret Server removed it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IdentityProviderId
    SAML identity provider ID

    .PARAMETER Id
    Certificate ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSamlIdentityProviderCertificate -TssSession $session -IdentityProviderId 2 -Id 5

    Removes certificate 5 from SAML identity provider 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssSamlIdentityProviderCertificate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssSamlIdentityProviderCertificate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $IdentityProviderId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CertificateId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'saml', 'identity-provider', $IdentityProviderId, 'certificate', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("SAML identity provider $IdentityProviderId certificate $Id","$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssSamlIdentityProviderCertificate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
