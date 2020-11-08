function Disable-TssSecret {
    <#
    .SYNOPSIS
    Disable a secret from Secret Server

    .DESCRIPTION
    Disables a secret from Secret Server

    .PARAMETER Id
    Secret ID to disable (mark inactive)

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> Disable-TssSecret -Id 93

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
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            $invokeParams.Method = 'DELETE'

            if (-not $PSCmdlet.ShouldProcess("DELETE $uri)")) { return }
            Write-Verbose "Disabling secret: $secret"
            $restResponse = Invoke-TssRestApi @invokeParams -ErrorVariable err -ErrorAction SilentlyContinue

            if ($err[0].Exception -like "*Bad Request*") {
                $status = "Does not exists"
            }
            if (-not $Raw) {
                if (-not $status) {
                    $status = (Get-TssSecret -Id $secret).Status
                }

                [PSCustomObject]@{
                    SecretId   = if ($restResponse.id -eq $secret) { $restResponse.id } else { $secret }
                    ObjectType = $restResponse.objectType
                    Status     = $status
                }
            } else {
                $restResponse
            }
        }
    }
}