function Get-TssSamlIdentityProvider {
    <#
    .SYNOPSIS
    Get a SAML identity provider

    .DESCRIPTION
    Returns a SAML identity provider by ID, with its settings and certificates.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SAML identity provider ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSamlIdentityProvider -TssSession $session -Id 2

    Returns SAML identity provider 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSamlIdentityProvider

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSamlIdentityProvider.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SamlIdentityProvider')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('IdentityProviderId')]
        [int[]]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'configuration', 'saml', 'identity-provider', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSamlIdentityProvider request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SamlIdentityProvider](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SamlIdentityProvider]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
