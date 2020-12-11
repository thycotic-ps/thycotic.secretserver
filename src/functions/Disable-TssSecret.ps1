function Disable-TssSecret {
    <#
    .SYNOPSIS
    Disable a secret from Secret Server

    .DESCRIPTION
    Disables a secret from Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Secret ID to disable (mark inactive)

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Disable-TssSecret -Id 93

    Disables secret 93

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

        # Delete only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Disable-TssSecret'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {

            foreach ($secret in $Id) {
                $uri = $TssSession.SecretServerUrl + ($TssSession.ApiVersion, "secrets", $secret.ToString() -join '/')

                $invokeParams.Uri = $Uri
                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $body")) { return }
                Write-Verbose "Disabling secret: $secret"

                try {
                    $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop -ErrorVariable err
                } catch {
                    if ($err.Exception -like "*Bad Request*") {
                        throw "$secret does not exists"
                    } else {
                        throw $err
                    }
                }

                if (-not $Raw) {
                    [PSCustomObject]@{
                        Id         = $restResponse.id
                        ObjectType = $restResponse.objectType
                    }
                } else {
                    $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}