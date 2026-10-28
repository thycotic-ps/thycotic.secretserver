function Search-TssPlatformSsFederation {
    <#
    .SYNOPSIS
    Get the Secret Server federations for Platform integration

    .DESCRIPTION
    Get the OpenID Connect and SAML federations of this Secret Server that Platform data integration would consume. Returns one object with an OidcFederations and a SamlFederations list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Search-TssPlatformSsFederation -TssSession $session).SamlFederations

    List the SAML federations

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsFederation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsFederation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformIntegration.SsFederation')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'ss-federations' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformSsFederation request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformIntegration.SsFederation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformIntegration.SsFederation]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
