function Set-Secret {
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
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
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
        [string]
        $Comment,

        # Field name (slug) of the secret
        [Parameter(ParameterSetName = 'all')]
        [Parameter(Mandatory, ParameterSetName = 'field')]
        [Alias('FieldName')]
        [string]
        $Field,

        # Value to set for the provided field
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'field')]
        [string]
        $Value,

        # Clear/blank out the field value
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'field')]
        [switch]
        $Clear,

        # Email when changed to true
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'email')]
        [switch]
        $EmailWhenChanged,

        # Email when viewed to true
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'email')]
        [switch]
        $EmailWhenViewed,

        # Email when HB fails to true
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'email')]
        [switch]
        $EmailWhenHeartbeatFails
    )
    begin {
        $setSecretParams = . $SetSecretParams $PSBoundParameters
        $invokeParams = @{ }

        $fieldParamSet = . $ParameterSetParams 'Set-TssSecret' 'field'
        $emailParamSet = . $ParameterSetParams 'Set-TssSecret' 'email'
        $generalParamSet = . $ParameterSetParams 'Set-TssSecret' 'general'

        # Need to know if any of the params provided are in the specific parameter sets
        # if they are not we will null out the variable so the code below is not triggered
        $fieldParams = @()
        foreach ($f in $fieldParamSet) {
            if ($setSecretParams.Contains($f)) {
                $fieldParams += $f
            }
        }

        $emailParams = @()
        foreach ($e in $emailParamSet) {
            if ($setSecretParams.Contains($e)) {
                $emailParams += $e
            }
        }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setSecretParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken

            foreach ($secret in $Id) {
                Write-Verbose "Working on field parameter set values"
                if ($fieldParams.Count -gt 0) {
                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'fields', $Field -join "/"
                    if ($setSecretParams.Contains('Clear') -and $setSecretParams.Contains('Value')) {
                        Write-Warning "Clear and Value provided, only one is supported"
                        return
                    }

                    $body = @{}

                    if ($setSecretParams['Clear']) {
                        $body.Add('value',"")
                    }
                    if ($setSecretParams['Value']) {
                        $body.Add('value',$Value)
                    }
                    $invokeParams.Uri = $uri
                    $invokeParams.Body = $body | ConvertTo-Json
                    $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                    $invokeParams.Method = 'PUT'

                    if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                    Write-Verbose "$($invokeParams.Method) $uri with $body"
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting field $Field on secret [$secret]"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }

                    if ($restResponse -eq $Value) {
                        Write-Verbose "Secret [$secret] field $Field updated successfully"
                    } elseif ($setSecretParams.Contains('Clear') -and ($null -eq $restResponse)) {
                        Write-Verbose "Secret [$secret] field $Field cleared successfully"
                    } else {
                        Write-Verbose "Response for secret [$secret]: $restResponse"
                    }
                }
                if ($emailParams.Count -gt 0) {
                    Write-Verbose "Working on email parameter set values"
                    # data object for Email Settings
                    $emailBody = @{
                        data = @{ }
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'email' -join "/"

                    if ($setSecretParams.Contains('EmailWhenChanged')) {
                        $sendEmailWhenChanged = @{
                            dirty = $true
                            value = $EmailWhenChanged
                        }
                        $emailBody.data.Add('sendEmailWhenChanged',$sendEmailWhenChanged)
                    }
                    if ($setSecretParams.Contains('EmailWhenViewed')) {
                        $sendEmailWhenViewed = @{
                            dirty = $true
                            value = $EmailWhenViewed
                        }
                        $emailBody.data.Add('sendEmailWhenViewd',$sendEmailWhenViewed)
                    }
                    if ($setSecretParams.Contains('EmailWhenHeartbeatFails')) {
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
                    Write-Verbose "$($invokeParams.Method) $uri with $body"
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting email settings, verify Email Server is configured in Secret Server"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }

                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenChanged' -and $setSecretParams['EmailWhenChanged']) {
                        Write-Verbose "Secret [$secret] email setting [Send Email When Changed] updated to $EmailWhenChanged"
                    }
                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenViewed' -and $setSecretParams['EmailWhenViewed']) {
                        Write-Verbose "Secret [$secret] email setting [Send Email When Viewed] updated to $EmailWhenViewed"
                    }
                    if ($restResponse.PSObject.Properties.Name -contains 'sendEmailWhenHeartbeatFails' -and $setSecretParams['EmailWhenHeartbeatFails']) {
                        Write-Verbose "Secret [$secret] email setting [Sned Email When Heartbeat Fails] updated to $EmailWhenHeartbeatFails"
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}