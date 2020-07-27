function Set-TssSecret {
    <#
    .SYNOPSIS
    Set a value for a given secret in Secret Server

    .DESCRIPTION
    Sets a secret property or field in Secret Server.

    .PARAMETER Id
    Secret ID to the property/field.

    .PARAMETER Comment
    Comment to provide for restricted secret (Require Comment is enabled)

    .PARAMETER Property
    Property name to set.

    .PARAMETER Field
    Field name to set

    .PARAMETER Value
    Value to set for field or property

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> Set-TssSecret -Id 93 -Property Name -Value "Server2 admin account"

    Sets secret 93's property, "Name", to "Server2 admin account"

    .EXAMPLE
    PS C:\> Set-TssSecret -Id 93 -Field Machine -Value "server2"

    Sets secret 93's field, "Machine", to "server2"

    .EXAMPLE
    PS C:\> Set-TssSecret -Id 1455 -Property enableInheritPermissions -Value $false -Comment "disabling folder inheritance"

    Sets secret 1455's property, "enableInheritPermissions", to false and providing required comment

    .EXAMPLE
    PS C:\> Set-TssSecret -Id 1455 -Field Notes -Value "to be decommissioned" -Comment "updating notes field"

    Sets secret 1455's field, "Notes", to the provided value providing required comment

    .NOTES
    Requires New-TssSession session be set
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # Secret Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Provide comment for restricted secret
        [string]
        $Comment,

        [Parameter(ParameterSetName = "prop")]
        [Alias('PropertyName')]
        [string]
        $Property,

        [Parameter(ParameterSetName = "field")]
        [Alias('FieldName')]
        [string]
        $Field,

        [Parameter(ParameterSetName = "prop",Mandatory)]
        [Parameter(ParameterSetName = "field",Mandatory)]
        [string]
        $Value,

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
            try {
                $params = @{
                    Id              = $secret
                    Raw             = $true
                    Comment         = $Comment
                    WarningVariable = "warn"
                    WarningAction   = "Stop"
                }
                $cSecret = Get-TssSecret @params
            } catch {
                # Warning output by Get call
            }

            if ($cSecret) {
                $props = $cSecret.PSObject.Properties
                if ($Property) {
                    if ($props["$Property"]) {
                        $cSecret.$Property = $Value
                    } else {
                        Write-Warning "Property [$Property] not found on secret [$secret]"
                        continue
                    }

                    $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets", $secret.ToString() -join '/'

                    $invokeParams.Uri = $Uri
                    $invokeParams.PersonalAccessToken = $TssSession.AuthToken
                    $invokeParams.Body = $cSecret | ConvertTo-Json
                    $invokeParams.Method = 'PUT'

                    if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $body")) { return }
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop
                    } catch {
                        $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
                    }
                }
            }
            if ($Field) {
                $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets", $secret, "fields", $Field -join "/"

                $body = "{'value': '$Value'}"
                $invokeParams.Uri = $uri
                $invokeParams.Body = $body
                $invokeParams.PersonalAccessToken = $TssSession.AuthToken
                $invokeParams.Method = 'PUT'

                if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $body")) { return }
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop
                } catch {
                    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
                }
            }
        }

        if ($Raw -and $restResponse) {
            $restResponse
        }
        if ($errorResponse) {
            Write-Warning -Message "Issue setting secret [$secret]: $($errorResponse.message)"
        }
        if ($restResponse.code) {
            Write-Warning -Message "Issue setting secret [$secret]: $($restResponse.message)"
        }
    }
}