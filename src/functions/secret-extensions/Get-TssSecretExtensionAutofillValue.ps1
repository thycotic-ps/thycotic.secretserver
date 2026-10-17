function Get-TssSecretExtensionAutofillValue {
    <#
    .SYNOPSIS
    Get the web autofill values of a secret

    .DESCRIPTION
    Returns the username and password the browser extension fills in for a web secret at the given URL, plus its launcher settings.
    The output contains the password in clear text.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret ID

    .PARAMETER Url
    URL of the page to fill in; must match the URL stored on the secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretExtensionAutofillValue -TssSession $session -SecretId 42 -Url 'https://portal.example.com/login'

    Returns the autofill values of secret 42 for the portal login page

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretExtensionAutofillValue

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretExtensionAutofillValue.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretExtensions.AutofillValue')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $SecretId,

        [Parameter(Mandatory)]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-extensions', 'autofill-values' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'SecretId' {
                    $body.Add('secretId', $SecretId)
                }
                'Url' {
                    $body.Add('url', $Url)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretExtensionAutofillValue request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.model) {
                [Thycotic.PowerShell.SecretExtensions.AutofillValue](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.SecretExtensions.AutofillValue]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
