function Search-TssSecretsByUrl {
    <#
    .SYNOPSIS
    Search for Secrets that match a URL for Web Password Filler

    .DESCRIPTION
    Search for Secrets that match a URL for Web Password Filler

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretsByUrl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretsByUrl.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssWpfSecretsByUrl -TssSession $session -Url 'https://citibank.com/login'

    Return Secrets that match the URL provided

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretExtensions.Secret')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # URL to search against
        [string]
        $Url
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-extensions', 'search-by-url' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $invokeParams.Body = "`"$Url`""

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.model.Count -le 0 -and $restResponse.model.Length -eq 0) {
                Write-Warning "No records found"
            }
            if ($restResponse.model) {
                [Thycotic.PowerShell.SecretExtensions.Secret[]]$restResponse.model
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}