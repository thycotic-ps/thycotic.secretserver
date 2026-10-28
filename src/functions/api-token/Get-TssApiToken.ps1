function Get-TssApiToken {
    <#
    .SYNOPSIS
    Generate a new API token for the current user

    .DESCRIPTION
    Generate a new API token for the user that owns the session.
    Each call returns a new token, earlier tokens stay valid until they expire.
    The output carries the token value in GeneratedToken: treat it as a credential.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $token = Get-TssApiToken -TssSession $session

    Generates a new API token and stores the output in $token

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/api-token/Get-TssApiToken

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/api-token/Get-TssApiToken.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ApiToken.Token')]
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
            $uri = $TssSession.ApiUrl, 'api-token', 'generate-token' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssApiToken request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ApiToken.Token]@{
                    GeneratedToken = $restResponse.generatedToken.value
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
