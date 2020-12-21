function Get-TssSecret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Secret ID to retrieve, accepts an array of IDs

    .PARAMETER Comment
    Comment to provide for restricted secret (Require Comment is enabled)

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

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

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssSecret')]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Provide comment for restricted secret
        [string]
        $Comment,

        # output the raw response from the API endpoint
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
                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'GET'
                }

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                $restResponse = Invoke-TssRestApi @invokeParams

                if ($Raw) {
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