function Search-TssPlatformSsDomain {
    <#
    .SYNOPSIS
    Search the Secret Server domains for Platform integration

    .DESCRIPTION
    List the Active Directory and Azure AD domains of this Secret Server as Platform data integration sees them, with the engine hosts of each domain.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformSsDomain -TssSession $session | Where-Object IsAzure -EQ $false

    List the Active Directory domains

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformIntegration.SsDomain[]')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'ss-domains' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformSsDomain request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformIntegration.SsDomain[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformIntegration.SsDomain]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
