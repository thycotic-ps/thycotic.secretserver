function Set-TssSecret {
    <#
    .SYNOPSIS
    Set a value for a given secret in Secret Server

    .DESCRIPTION
    Sets a secret property or field in Secret Server.

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 93 -Field Machine -Value "server2"

    Sets secret 93's field, "Machine", to "server2"

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 1455 -Field Notes -Value "to be decommissioned" -Comment "updating notes field"

    Sets secret 1455's field, "Notes", to the provided value providing required comment

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 113 -Field Notes -Clear

    Sets secret 1455's field, "Notes", to an empty value

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 113 -EmailWhenViewed

    Sets secret 1455 email when viewed setting to true

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 113 -EmailWhenChanged:$false

    Sets secret 1455 disables emailing when changed

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = "field")]
        [string]
        $Comment,

        # Field name (slug) of the secret
        [Parameter(Mandatory,
            ParameterSetName = "field")]
        [Alias('FieldName')]
        [string]
        $Field,

        # Value to set for the provided field
        [Parameter(ParameterSetName = "field")]
        [string]
        $Value,

        # Clear/blank out the field value
        [Parameter(ParameterSetName = "field")]
        [switch]
        $Clear,

        # Email when changed to true
        [Parameter(ParameterSetName= "email")]
        [switch]
        $EmailWhenChanged,

        # Email when viewed to true
        [Parameter(ParameterSetName= "email")]
        [switch]
        $EmailWhenViewed,

        # Email when HB fails to true
        [Parameter(ParameterSetName= "email")]
        [switch]
        $EmailWhenHeartbeatFails
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Set-TssSecret'
        $invokeParams = @{ }

        # data object for Email Settings
        $emailBody = @{
            data = @{ }
        }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken

            foreach ($secret in $Id) {
                if ($TssParams.Contains('Field')) {
                    $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret, "fields", $Field -join "/")

                    if ([string]::IsNullOrEmpty($Value)) {
                        $Value = ""
                    }
                    if ($TssParams.Contains('Clear') -and $TssParams.Contains('Value')) {
                        Write-Warning "Clear and Value provided, only one is supported"
                        return
                    } elseif ($TssParams.Contains('Clear')) {
                        $body = '{"value": ""}'
                    } else {
                        $body = "{'value': '$Value'}"
                    }
                    $invokeParams.Uri = $uri
                    $invokeParams.Body = $body
                    $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                    $invokeParams.Method = 'PUT'

                    if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting field $Field on secret [$secret]"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }

                    if ($restResponse -eq $Value) {
                        Write-Verbose "$secret field $Field updated successfully"
                    } elseif ($TssParams.Contains('Clear') -and ($null -eq $restResponse)) {
                        Write-Verbose "$secret field $Field cleared successfully"
                    } else {
                        $restResponse
                    }
                }
                if ($TssParams.Contains('EmailWhenChanged') -or $TssParams.Contains('EmailWhenViewed') -or $TssParams.Contains('EmailWhenHeartbeatFails')) {
                    $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret, "email" -join "/")

                    if ($TssParams.Contains('EmailWhenChanged')) {
                        $sendEmailWhenChanged = @{
                            dirty = $true
                            value = $EmailWhenChanged
                        }
                        $emailBody.data.Add('sendEmailWhenChanged',$sendEmailWhenChanged)
                    }
                    if ($TssParams.Contains('EmailWhenViewed')) {
                        $sendEmailWhenViewed = @{
                            dirty = $true
                            value = $EmailWhenViewed
                        }
                        $emailBody.data.Add('sendEmailWhenViewd',$sendEmailWhenViewed)
                    }
                    if ($TssParams.Contains('EmailWhenHeartbeatFails')) {
                        $sendEmailWhenHeartbeatFails = @{
                            dirty = $true
                            value = $EmailWhenHeartbeatFails
                        }
                        $emailBody.data.Add('sendEmailWhenHeartbeatFails',$sendEmailWhenHeartbeatFails)
                    }
                    $invokeParams.Uri = $uri
                    $invokeParams.Body = $emailBody | ConvertTo-Json
                    $invokeParams.Method = 'PATCH'

                    if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }

                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting email settings, verify Email Server is configured in Secret Server"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}