function Get-TssSecret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 1723 -Comment "Accessing application Y"

    Returns secret associated with the Secret ID, 1723, providing required comment

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> $secret = Get-TssSecret -TssSession $session -Id 46
    PS C:\> $cred = $secret.GetCredential()

    Gets Secret ID 46 and then output a PSCredential to utilize in script workflow

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> $secret = Search-TssSecret -TssSesion $session -FieldSlug server -FieldText 'sql1' | Get-TssSecret
    PS C:\> $cred = $secret.GetCredential()
    PS C:\> $serverName = $secret.GetValue('server')

    Search for the secret with server value of sql1 and pull the secret details
    Call GetCredential() method to get the PSCredential object with the username and password
    Call GetValue() method passing the slug name to grab the ItemValue of the server field.

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssSecret')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret ID to retrieve
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [string]
        $Comment,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssSecret'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret.ToString() -join '/')
                if ($Comment) {
                    $uri = $uri, "restricted" -join "/"
                    $body = "{'comment':'$Comment', 'includeInactive':'$true'}"
                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $body
                } else {
                    $uri = $uri, "includeInactive=true" -join "?"
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                }

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting secret [$secret]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($tssParams['Raw']) {
                    return $restResponse
                }
                if ($restResponse) {
                    . $GetTssSecretObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}