function Set-Secret {
    <#
    .SYNOPSIS
    Set various settings or fields for a given secret

    .DESCRIPTION
    Set various settings or fields for a given secret.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 93 -Field Machine -Value "server2"

    Sets secret 93's field, "Machine", to "server2"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 1455 -Field Notes -Value "to be decommissioned" -Comment "updating notes field"

    Sets secret 1455's field, "Notes", to the provided value providing required comment

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 345 -FolderId 3

    Move Secret 345 to folder ID 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 113 -Field Notes -Clear

    Sets secret 1455's field, "Notes", to an empty value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 113 -EmailWhenViewed

    Sets secret 1455 email when viewed setting to true

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 113 -EmailWhenChanged:$false

    Sets secret 1455 disables emailing when changed

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecret -TssSession $session -Id 113 -ForceCheckIn

    Sets secret 1455 disables emailing when changed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecret

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Force check-in of the Secret
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [Parameter(ParameterSetName = 'checkIn')]
        [switch]
        $ForceCheckIn,

        # Associated Ticket Number
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketNumber,

        #Associated Ticket System ID
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId,

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

        # Whether Auto Change is enabled
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'password')]
        [switch]
        $AutoChangeEnabled,

        # Manual password to use on next Auto Change
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'password')]
        [securestring]
        $AutoChangeNextPassword,

        # Whether the Secret inherits permissions from the containing folder
        [Parameter(ParameterSetName = 'all')]
        [Alias('EnableInheritPermissions')]
        [switch]
        $EnableInheritPermission,

        # Whether Secret Policy is inherited from containing folder
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [switch]
        $EnableInheritSecretPolicy,

        # Folder (ID)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'general')]
        [Alias('Folder')]
        [int]
        $FolderId,

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
        [Alias('TemplateId')]
        [int]
        $Template,

        # Check-In a Secret, can be combined with ForceCheckIn to forcibly check the Secret in
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'checkIn')]
        [switch]
        $CheckIn
    )
    begin {
        $setSecretParams = $PSBoundParameters

        $fieldParamSet = . $ParameterSetParams 'Set-TssSecret' 'field'
        $emailParamSet = . $ParameterSetParams 'Set-TssSecret' 'email'
        $generalParamSet = . $ParameterSetParams 'Set-TssSecret' 'general'

        # Need to know if any of the params provided are in the specific parameter sets
        # if they are not we will null out the variable so the code below is not triggered
        $fieldParams = @()
        foreach ($f in $fieldParamSet) {
            if ($setSecretParams.ContainsKey($f)) {
                $fieldParams += $f
            }
        }
        $emailParams = @()
        foreach ($e in $emailParamSet) {
            if ($setSecretParams.ContainsKey($e)) {
                $emailParams += $e
            }
        }
        $generalParams = @()
        foreach ($g in $generalParamSet) {
            if ($setSecretParams.ContainsKey($g)) {
                $generalParams += $g
            }
        }

        # Require Get-TssSecret and PUT /secrets/{id} endpoint
        $passwordParamSet = . $ParameterSetParams 'Set-TssSecret' 'password'
        $folderParamSet = . $ParameterSetParams 'Set-TssSecret' 'folder'
        $otherParams = @()
        foreach ($p in $passwordParamSet) {
            if ($setSecretParams.ContainsKey($p)) {
                $otherParams += $p
            }
        }
        foreach ($f in $folderParamSet) {
            if ($setSecretParams.ContainsKey($f)) {
                $otherParams += $f
            }
        }

        # restricted params
        $restrictedParamSet = . $ParameterSetParams 'Set-TssSecret' 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($setSecretParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }

        $invokeParamsField = . $GetInvokeTssParams $TssSession
        $invokeParamsEmail = . $GetInvokeTssParams $TssSession
        $invokeParamsGenearl = . $GetInvokeTssParams $TssSession
        $invokeParamsOther = . $GetInvokeTssParams $TssSession
        $invokeParamsCheckIn = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setSecretParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                if ($otherParams.Count -gt 0) {
                    $uri = $TssSession.ApiUrl, 'secrets', $secret -join '/'
                    $invokeParamsOther.Uri = $uri
                    $invokeParamsOther.Method = 'PUT'

                    $whatIfProcessing = 0
                    if ($setSecretParams.ContainsKey('AutoChangeEnabled') -and -not $PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsOther.Method) $uri updating AutoChangeEnabled to $AutoChangeEnabled")) {
                        $whatIfProcessing++
                    }
                    if ($setSecretParams.ContainsKey('AutoChangeNextPassword') -and -not $PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsOther.Method) $uri updating AutoChangeNextPassword to $AutoChangeNextPassword")) {
                        $whatIfProcessing++
                    }
                    if ($setSecretParams.ContainsKey('EnableInheritPermission') -and -not $PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsOther.Method) $uri updating Inherit Permission to $EnableInheritPermission")) {
                        $whatIfProcessing++
                    }

                    $getParams = @{
                        TssSession = $TssSession
                        Id         = $secret
                    }
                    if ($restrictedParams.Count -gt 0) {
                        $getParams.Add('ForceCheckIn', $ForceCheckIn)
                        $getParams.Add('TicketNumber', $TicketNumber)
                        $getParams.Add('TicketSystemId', $TicketSystemId)
                        $getParams.Add('Comment', $Comment)
                    }
                    if (-not $PSCmdlet.ShouldProcess("SecretId: $secret", "Calling Get-TssSecret with keys:`n $($getParams.Keys)`n and values: $($getParams.Values)")) {
                        $whatIfProcessing++
                    }

                    if ($whatIfProcessing -eq 0) {
                        try {
                            Write-Verbose "Calling Get-TssSecret with:`t$($getParams)`n"
                            $getSecret = Get-TssSecret @getParams
                        } catch {
                            Write-Error "Issue getting Secret [$secret] details: $_"
                        }

                        if ($getSecret) {
                            if ($restrictedParams.Count -gt 0) {
                                $getSecret.Add('ForceCheckIn', $ForceCheckIn)
                                $getSecret.Add('TicketNumber', $TicketNumber)
                                $getSecret.Add('TicketSystemId', $TicketSystemId)
                                $getSecret.Add('Comment', $Comment)
                            }

                            if ($setSecretParams.ContainsKey('AutoChangeEnabled')) {
                                $getSecret.AutoChangeEnabled = $AutoChangeEnabled
                            }
                            if ($setSecretParams.ContainsKey('AutoChangeNextPassword')) {
                                if ($setSecretParams.ContainsKey('AutoChangeEnabled') -and -not $AutoChangeEnabled) {
                                    Write-Warning "AutoChangeNextPassword requires AutoChange to be enabled. Please provide -AutoChangeEnabled parameter to enable it and set next manual password on secret [$secret]."
                                } elseif ($getSecret.AutoChangeEnabled -eq $false -and -not $AutoChangeEnabled) {
                                    Write-Warning "AutoChangeNextPassword require AutoChange to be enabled. AutoChange found disabled on secret [$secret]. Please provide -AutoChangeEnabled parameter to enable it and set next manual password."
                                } else {
                                    $getSecret.AutoChangeNextPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($AutoChangeNextPassword))
                                }
                            }
                            if ($setSecretParams.ContainsKey('EnableInheritPermission')) { $getSecret.EnableInheritPermissions = $EnableInheritPermission }
                            $invokeParamsOther.Body = $getSecret | ConvertTo-Json -Depth 5

                            Write-Verbose "$($invokeParamsOther.Method) $uri with:`t$($invokeParamsOther.Body)`n"
                            try {
                                $otherResponse = Invoke-TssRestApi @invokeParamsOther
                            } catch {
                                Write-Warning "Issue setting property on secret [$secret]"
                                $err = $_
                                . $ErrorHandling $err
                            }

                            if ($otherResponse.PSObject.Properties.Name -contains 'AutoChangeEnabled' -and $setSecretParams.ContainsKey('AutoChangeEnabled')) {
                                if ($otherResponse.AutoChangeEnabled -eq $AutoChangeEnabled) {
                                    Write-Verbose "Secret [$secret] AutoChangeEnabled was set to $AutoChangeEnabled"
                                }
                            }
                            if ($otherResponse.PSObject.Properties.Name -contains 'AutoChangeNextPassword' -and $setSecretParams.ContainsKey('AutoChangeNextPassword')) {
                                if ($otherResponse.AutoChangeNextPassword -eq $AutoChangeNextPassword) {
                                    Write-Verbose "Secret [$secret] AutoChangeNextPassword was set to $AutoChangeNextPassword"
                                }
                            }
                            if ($otherResponse.PSObject.Properties.Name -contains 'EnableInheritPermissions' -and $setSecretParams.ContainsKey('EnableInheritPermission')) {
                                if ($otherResponse.EnableInheritPermissions -eq $EnableInheritPermission) {
                                    Write-Verbose "Secret [$secret] EnableInheritPermissions was set to $EnableInheritPermission"
                                }
                            }
                        }
                    }
                }
                if ($fieldParams.Count -gt 0) {
                    Write-Verbose "Working on field parameter set values"

                    if ($setSecretParams.ContainsKey('Clear') -and $setSecretParams.ContainsKey('Value')) {
                        Write-Warning "Clear and Value provided, only one is supported"
                        return
                    }

                    $fieldBody = @{}
                    if ($setSecretParams.ContainsKey('Clear')) {
                        $fieldBody.Add('value',"")
                    }
                    if ($setSecretParams.ContainsKey('Value')) {
                        $fieldBody.Add('value',$Value)
                    }

                    if ($restrictedParams.Count -gt 0) {
                        switch ($restrictedParams) {
                            'Comment' { $fieldBody.Add('comment', $Comment) }
                            'ForceCheckIn' { $fieldBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                            'TicketNumber' { $fieldBody.Add('ticketNumber', $TicketNumber) }
                            'TicketSystemId' { $fieldBody.Add('ticketSystemId', $TicketSystemId) }
                        }
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'fields', $Field -join '/'
                    $invokeParamsField.Uri = $uri
                    $invokeParamsField.Method = 'PUT'
                    $invokeParamsField.Body = $fieldBody | ConvertTo-Json -Depth 5

                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsField.Method) $uri with:`n$($invokeParamsField.Body)`n")) {
                        Write-Verbose "$($invokeParamsField.Method) $uri with:`n$fieldBody`n"
                        try {
                            $fieldResponse = Invoke-TssRestApi @invokeParamsField
                        } catch {
                            Write-Warning "Issue setting field $Field on secret [$secret]"
                            $err = $_
                            . $ErrorHandling $err
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
                            value = [boolean]$EmailWhenChanged
                        }
                        $emailBody.data.Add('sendEmailWhenChanged',$sendEmailWhenChanged)
                    }
                    if ($setSecretParams.ContainsKey('EmailWhenViewed')) {
                        $sendEmailWhenViewed = @{
                            dirty = $true
                            value = [boolean]$EmailWhenViewed
                        }
                        $emailBody.data.Add('sendEmailWhenViewed',$sendEmailWhenViewed)
                    }
                    if ($setSecretParams.ContainsKey('EmailWhenHeartbeatFails')) {
                        $sendEmailWhenHeartbeatFails = @{
                            dirty = $true
                            value = [boolean]$EmailWhenHeartbeatFails
                        }
                        $emailBody.data.Add('sendEmailWhenHeartbeatFails',$sendEmailWhenHeartbeatFails)
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'email' -join '/'
                    $invokeParamsEmail.Uri = $uri
                    $invokeParamsEmail.Method = 'PATCH'
                    $invokeParamsEmail.Body = $emailBody | ConvertTo-Json -Depth 5

                    if ($restrictedParams.Count -gt 0) {
                        if ($PSCmdlet.ShouldProcess("SecretId: $secret", "Pre-check out secret for setting email settings")) {
                            . $CheckOutSecret $TssSession $setSecretParams $secret
                        }
                    }
                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsEmail.Method) $uri with:`n$($invokeParamsEmail.Body)`n")) {
                        Write-Verbose "$($invokeParamsEmail.Method) $uri with:`n$($invokeParamsEmail.Body)`n"
                        try {
                            $emailResponse = Invoke-TssRestApi @invokeParamsEmail
                        } catch {
                            Write-Warning "Issue configuring [$secret] email settings, verify Email Server is configured in Secret Server"
                            $err = $_
                            . $ErrorHandling $err
                        }

                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenChanged' -and $setSecretParams.ContainsKey('EmailWhenChanged')) {
                            Write-Verbose "Secret [$secret] email setting [Send Email When Changed] updated to $EmailWhenChanged"
                        }
                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenViewed' -and $setSecretParams.ContainsKey('EmailWhenViewed')) {
                            Write-Verbose "Secret [$secret] email setting [Send Email When Viewed] updated to $EmailWhenViewed"
                        }
                        if ($emailResponse.PSObject.Properties.Name -contains 'sendEmailWhenHeartbeatFails' -and $setSecretParams.ContainsKey('EmailWhenHeartbeatFails')) {
                            Write-Verbose "Secret [$secret] email setting [Send Email When Heartbeat Fails] updated to $EmailWhenHeartbeatFails"
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
                            value = [boolean]$Active
                        }
                        $generalBody.data.Add('active',$setActive)
                    }
                    if ($setSecretParams.ContainsKey('EnableInheritSecretPolicy')) {
                        $setInheritance = @{
                            dirty = $true
                            value = [boolean]$EnableInheritSecretPolicy
                        }
                        $generalBody.data.Add('enableInheritSecretPolicy',$setInheritance)
                    }
                    if ($setSecretParams.ContainsKey('FolderId')) {
                        $setFolder = @{
                            dirty = $true
                            value = $FolderId
                        }
                        $generalBody.data.Add('folder',$setFolder)
                    }
                    if ($setSecretParams.ContainsKey('GenerateSshKeys')) {
                        #does not require dirty and value properties
                        $generalBody.data.Add('generateSshKeys', [boolean]$GenerateSshKeys)
                    }
                    if ($setSecretParams.ContainsKey('HeartbeatEnabled')) {
                        $setHb = @{
                            dirty = $true
                            value = "$HeartbeatEnabled"
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
                            value = [boolean]$IsOutOfSync
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

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'general' -join '/'
                    $invokeParamsGenearl.Uri = $uri
                    $invokeParamsGenearl.Method = 'PATCH'
                    $invokeParamsGenearl.Body = $generalBody | ConvertTo-Json -Depth 5

                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsGenearl.Method) $uri with:`n$($invokeParamsGenearl.Body)`n")) {
                        Write-Verbose "$($invokeParamsGenearl.Method) $uri with:`n$($invokeParamsGenearl.Body)`n"
                        try {
                            $generalResponse = Invoke-TssRestApi @invokeParamsGenearl
                        } catch {
                            Write-Warning "Issue configuring general settings on [$secret]"
                            $err = $_
                            . $ErrorHandling $err
                        }

                        if ($generalResponse.id -eq $secret -and $generalResponse.name.value -eq $SecretName) {
                            Write-Verbose "Secret [$secret] name set to [$($generalResponse.name.value)]"
                        }
                        if ($generalResponse.id -eq $secret -and $generalResponse.active.value -eq $Active) {
                            Write-Verbose "Secret [$secret] Active set to [$($generalResponse.active.value)]"
                        }
                    }
                }
                if ($setSecretParams.ContainsKey('CheckIn')) {
                    Write-Verbose "Working on check-in"
                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'check-in' -join '/'
                    $invokeParamsCheckIn.Uri = $uri
                    $invokeParamsCheckIn.Method = 'POST'

                    $checkInBody = @{}
                    if ($restrictedParams.Count -gt 0) {
                        switch ($restrictedParams) {
                            'Comment' { $checkInBody.Add('comment', $Comment) }
                            'ForceCheckIn' { $checkInBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                            'TicketNumber' { $checkInBody.Add('ticketNumber', $TicketNumber) }
                            'TicketSystemId' { $checkInBody.Add('ticketSystemId', $TicketSystemId) }
                        }
                    }

                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'check-in' -join '/'
                    $invokeParamsCheckIn.Uri = $uri
                    $invokeParamsCheckIn.Method = 'POST'
                    $invokeParamsCheckIn.Body = $checkInBody | ConvertTo-Json -Depth 5

                    if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParamsCheckIn.Method) $uri with:`n$($invokeParamsCheckIn.Body)`n")) {
                        Write-Verbose "$($invokeParamsCheckIn.Method) $uri with:`n$checkInBody`n"
                        try {
                            $checkInResponse = Invoke-TssRestApi @invokeParamsCheckIn
                        } catch {
                            Write-Warning "Issue performing check-in on secret [$secret]"
                            $err = $_
                            . $ErrorHandling $err
                        }
                    }

                    if ($checkInResponse.checkedOut) {
                        Write-Warning "Secret [$secret] not checked in"
                    } else {
                        Write-Verbose "Secret [$secret] checked in"
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}