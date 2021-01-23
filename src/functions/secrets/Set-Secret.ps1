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
        $EmailWhenHeartbeatFails,

        # Set the secret active secret is active
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $Active,

        # Whether Secret Policy is inherited from containing folder
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $EnableInheritSecretPolicy,

        # Folder (ID)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [int]
        $Folder,

        # Generate new SSH Keys
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $GenerateSshKeys,

        # Heartbeat enabled
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $HeartbeatEnabled,

        # Secret out of sync
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $IsOutOfSync,

        # Secret name
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [string]
        $SecretName,

        # Secret Policy (ID)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [int]
        $SecretPolicy,

        # Secret Site
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [int]
        $Site,

        # Secret Template (ID)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [int]
        $Template
    )
    begin {
        $setSecretParams = $PSBoundParameters

        $fieldParamSet = . $ParameterSetParams 'Set-TssSecret' 'field'
        $emailParamSet = . $ParameterSetParams 'Set-TssSecret' 'email'
        $generalParamSet = . $ParameterSetParams 'Set-TssSecret' 'general'

        # Need to know if any of the params provided are in the specific parameter sets
        # if they are not we will null out the variable so the code below is not triggered
        $fieldParams = @()
        $invokeParamsField = @{ }
        foreach ($f in $fieldParamSet) {
            if ($setSecretParams.ContainsKey($f)) {
                $fieldParams += $f
            }
        }
        $emailParams = @()
        $invokeParamsEmail = @{ }
        foreach ($e in $emailParamSet) {
            if ($setSecretParams.ContainsKey($e)) {
                $emailParams += $e
            }
        }
        $generalParams = @()
        $invokeParamsGenearl = @{ }
        foreach ($g in $generalParamSet) {
            if ($setSecretParams.ContainsKey($g)) {
                $generalParams += $g
            }
        }
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setSecretParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $invokeParamsField.PersonalAccessToken = $TssSession.AccessToken
            $invokeParamsEmail.PersonalAccessToken = $TssSession.AccessToken
            $invokeParamsGenearl.PersonalAccessToken = $TssSession.AccessToken

            foreach ($secret in $Id) {
                if ($fieldParams.Count -gt 0) {
                    Write-Verbose "Working on field parameter set values"

                    if ($setSecretParams.ContainsKey('Clear') -and $setSecretParams.ContainsKey('Value')) {
                        Write-Warning "Clear and Value provided, only one is supported"
                        return
                    }

                    $body = @{}
                    if ($setSecretParams.ContainsKey('Clear')) {
                        $body.Add('value',"")
                    }
                    if ($setSecretParams.ContainsKey('Value')) {
                        $body.Add('value',$Value)
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'fields', $Field -join "/"
                    $invokeParamsField.Uri = $uri
                    $invokeParamsField.Method = 'PUT'
                    $invokeParamsField.Body = $body | ConvertTo-Json

                    if ($PSCmdlet.ShouldProcess("$($invokeParamsField.Method) $uri with:`n$($invokeParamsField.Body)")) {
                        Write-Verbose "$($invokeParamsField.Method) $uri with:`n$body"
                        try {
                            $fieldResponse = Invoke-TssRestApi @invokeParamsField
                        } catch {
                            Write-Warning "Issue setting field $Field on secret [$secret]"
                            $err = $_.ErrorDetails.Message
                            Write-Error $err
                        }

                        if ($fieldResponse -eq $Value) {
                            Write-Verbose "Secret [$secret] field $Field updated successfully"
                        } elseif ($setSecretParams.ContainsKey('Clear') -and ($null -eq $fieldResponse)) {
                            Write-Verbose "Secret [$secret] field $Field cleared successfully"
                        } else {
                            Write-Verbose "Response for secret [$secret]: $fieldResponse"
                        }
                    }
                }
                if ($emailParams.Count -gt 0) {
                    Write-Verbose "Working on email parameter set values"

                    # data object for Email Settings
                    $emailBody = @{
                        data = @{ }
                    }

                    if ($setSecretParams.ContainsKey('EmailWhenChanged')) {
                        $sendEmailWhenChanged = @{
                            dirty = $true
                            value = $EmailWhenChanged
                        }
                        $emailBody.data.Add('sendEmailWhenChanged',$sendEmailWhenChanged)
                    }
                    if ($setSecretParams.ContainsKey('EmailWhenViewed')) {
                        $sendEmailWhenViewed = @{
                            dirty = $true
                            value = $EmailWhenViewed
                        }
                        $emailBody.data.Add('sendEmailWhenViewd',$sendEmailWhenViewed)
                    }
                    if ($setSecretParams.ContainsKey('EmailWhenHeartbeatFails')) {
                        $sendEmailWhenHeartbeatFails = @{
                            dirty = $true
                            value = $EmailWhenHeartbeatFails
                        }
                        $emailBody.data.Add('sendEmailWhenHeartbeatFails',$sendEmailWhenHeartbeatFails)
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'email' -join "/"
                    $invokeParamsEmail.Uri = $uri
                    $invokeParamsEmail.Method = 'PATCH'
                    $invokeParamsEmail.Body = $emailBody | ConvertTo-Json

                    if ($PSCmdlet.ShouldProcess("$($invokeParamsEmail.Method) $uri with:`n$($invokeParamsEmail.Body)")) {
                        Write-Verbose "$($invokeParamsEmail.Method) $uri with:`n$($invokeParamsEmail.Body)"
                        try {
                            $emailResponse = Invoke-TssRestApi @invokeParamsEmail
                        } catch {
                            Write-Warning "Issue configuring [$secret] email settings, verify Email Server is configured in Secret Server"
                            $err = $_.ErrorDetails.Message
                            Write-Error $err
                        }

                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenChanged' -and $setSecretParams.ContainsKey('EmailWhenChanged')) {
                            Write-Verbose "Secret [$secret] email setting [Send Email When Changed] updated to $EmailWhenChanged"
                        }
                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenViewed' -and $setSecretParams.ContainsKey('EmailWhenViewed')) {
                            Write-Verbose "Secret [$secret] email setting [Send Email When Viewed] updated to $EmailWhenViewed"
                        }
                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenHeartbeatFails' -and $setSecretParams.ContainsKey('EmailWhenHeartbeatFails')) {
                            Write-Verbose "Secret [$secret] email setting [Sned Email When Heartbeat Fails] updated to $EmailWhenHeartbeatFails"
                        }
                    }
                }
                if ($generalParams.Count -gt 0) {
                    Write-Verbose "Working on general parameter set values"
                    # data object for General Settings
                    # Each object added to data requires dirty (true) and value property
                    $generalBody = @{
                        data = @{ }
                    }

                    if ($setSecretParams.ContainsKey('Active')) {
                        $setActive = @{
                            dirty = $true
                            value = $Active
                        }
                        $generalBody.data.Add('active',$setActive)
                    }
                    if ($setSecretParams.ContainsKey('EnableInheritSecretPolicy')) {
                        $setInheritance = @{
                            dirty = $true
                            value = $EnableInheritSecretPolicy
                        }
                        $generalBody.data.Add('enableInheritSecretPolicy',$setInheritance)
                    }
                    if ($setSecretParams.ContainsKey('Folder')) {
                        $setFolder = @{
                            dirty = $true
                            value = $Folder
                        }
                        $generalBody.data.Add('folder',$setFolder)
                    }
                    if ($setSecretParams.ContainsKey('GenerateSshKeys')) {
                        #does not require dirty and value properties
                        $generalBody.data.Add('generateSshKeys',$GenerateSshKeys)
                    }
                    if ($setSecretParams.ContainsKey('HeartbeatEnabled')) {
                        $setHb = @{
                            dirty = $true
                            value = $HeartbeatEnabled
                        }
                        $generalBody.data.Add('heartbeatEnabled',$setHb)
                    }
                    if ($setSecretParams.ContainsKey('SecretPolicy')) {
                        $setSecretPolicy = @{
                            dirty = $true
                            value = $SecretPolicy
                        }
                        $generalBody.data.Add('secretPolicy',$setSecretPolicy)
                    }
                    if ($setSecretParams.ContainsKey('Site')) {
                        $setSite = @{
                            dirty = $true
                            value = $Site
                        }
                        $generalBody.data.Add('enableInheritSecretPolicy',$setSite)
                    }
                    if ($setSecretParams.ContainsKey('Template')) {
                        $setTemplate = @{
                            dirty = $true
                            value = $Template
                        }
                        $generalBody.data.Add('template',$setTemplate)
                    }
                    if ($setSecretParams.ContainsKey('IsOutOfSync')) {
                        $setOutOfSync = @{
                            dirty = $true
                            value = $IsOutOfSync
                        }
                        $generalBody.data.Add('isOutOfSync',$setOutOfSync)
                    }
                    if ($setSecretParams.ContainsKey('SecretName')) {
                        $setName = @{
                            dirty = $true
                            value = $SecretName
                        }
                        $generalBody.data.Add('name',$setName)
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'general' -join "/"
                    $invokeParamsGenearl.Uri = $uri
                    $invokeParamsGenearl.Method = 'PATCH'
                    $invokeParamsGenearl.Body = $generalBody | ConvertTo-Json

                    if ($PSCmdlet.ShouldProcess("$($invokeParamsGenearl.Method) $uri with:`n$($invokeParamsGenearl.Body)")) {
                        Write-Verbose "$($invokeParamsGenearl.Method) $uri with:`n$($invokeParamsGenearl.Body)"
                        try {
                            $generalResponse = Invoke-TssRestApi @invokeParamsGenearl
                        } catch {
                            Write-Warning "Issue configuring general settings on [$secret]"
                            $err = $_.ErrorDetails.Message
                            Write-Error $err
                        }

                        if ($generalResponse.id -eq $secret -and $generalResponse.name.value -eq $SecretName) {
                            Write-Verbose "Secret [$secret] name set to [$($generalResponse.name.value)]"
                        }
                        if ($generalResponse.id -eq $secret -and $generalResponse.active.value -eq $Active) {
                            Write-Verbose "Secret [$secret] Active set to [$($generalResponse.active.value)]"
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}