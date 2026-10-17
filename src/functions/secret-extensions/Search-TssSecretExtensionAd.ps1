function Search-TssSecretExtensionAd {
    <#
    .SYNOPSIS
    Search secrets by Active Directory domain

    .DESCRIPTION
    Returns the secrets that match an Active Directory domain, as the browser extension finds them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Domain
    Active Directory domain, for example corp.example.com

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretExtensionAd -TssSession $session -Domain 'corp.example.com'

    Returns the secrets that match the corp.example.com domain

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionAd

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionAd.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretExtensions.Secret[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Domain
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-extensions', 'search-ad-secrets-by-domain' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $invokeParams.Body = ConvertTo-Json -InputObject $Domain -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretExtensionAd request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.model) {
                [Thycotic.PowerShell.SecretExtensions.Secret[]](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.SecretExtensions.Secret]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
