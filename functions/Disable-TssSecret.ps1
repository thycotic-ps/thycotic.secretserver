function Disable-TssSecret {
    <#
    .SYNOPSIS
    Disable a secret from Secret Server

    .DESCRIPTION
    Disables a secret from Secret Server.

    .PARAMETER Id
    Secret ID to disable (mark inactive).

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\ > Disable-TssSecret -Id 93

    Disables secret 93

    .NOTES
    Requires New-TssSession session be set
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
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
        $invokeParams = @{ }
    }

    process {
        . $TestTssSession -Session

        foreach ($secret in $Id) {
            $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets", $secret.ToString() -join '/'

            $invokeParams.Uri = $Uri
            $invokeParams.PersonalAccessToken = $TssSession.AuthToken
            $invokeParams.Method = 'DELETE'

            if (-not $PSCmdlet.ShouldProcess("DELETE $uri)")) { return }
            $restResponse = Invoke-TssRestApi @invokeParams
            if (-not $Raw) {
                [PSCustomObject]@{
                    SecretId   = $restResponse.id
                    ObjectType = $restResponse.objectType
                    Status = (Get-TssSecret -Id $secret -Inactive).Status
                }
            } else {
                $restResponse
            }
        }
    }
}