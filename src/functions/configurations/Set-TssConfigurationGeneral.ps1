function Set-TssConfigurationGeneral {
    <#
    .SYNOPSIS
    Set general configuration

    .DESCRIPTION
    Set general configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationGeneral -TssSession $session -EnablePersonalFolders:$false

    Disable Personal Folders

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationGeneral -TssSession $session -TimeZone (Get-TimeZone).Id

    Set Secret Server Time Zone to the current user's Windows' default TimeZone.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationGeneral

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationGeneral.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Enable Personal Folders
        [Parameter(ParameterSetName = 'folders')]
        [switch]
        $EnablePersonalFolders,

        # Personal Folder Name
        [Parameter(ParameterSetName = 'folders')]
        [switch]
        $PersonalFolderName,

        # Personal Folder Name Format (DisplayName, UsernameAndDomain)
        [Parameter(ParameterSetName = 'folders')]
        [Thycotic.PowerShell.Enums.PersonalFolderNameOption]
        $PersonalFolderFormat,

        # Personal Folder warning message
        [Parameter(ParameterSetName = 'folders')]
        [string]
        $PersonalFolderWarning,

        # Personal Folder Require View Permission
        [Parameter(ParameterSetName = 'folders')]
        [switch]
        $PersonalFolderRequireView,

        # Show Personal Folder warning message
        [Parameter(ParameterSetName = 'folders')]
        [switch]
        $PersonalFolderEnableWarning,

        # Allow duplicate secret names
        [Parameter(ParameterSetName = 'permissions')]
        [switch]
        $AllowDuplicationSecretName,

        # Allow View Rights on Secret to read Next Password for RPC
        [Parameter(ParameterSetName = 'permissions')]
        [switch]
        $AllowViewNextPassword,

        # Default permissions to apply when Secret is created (InheritsPermissions, CopyFromFolder, OnlyAllowCreator)
        [Parameter(ParameterSetName = 'permissions')]
        [Thycotic.PowerShell.Enums.SecretPermissionType]
        $DefaultSecretPermission,

        # Allow approval for access from email
        [Parameter(ParameterSetName = 'permissions')]
        [switch]
        $EnableApprovalFromEmail,

        # Force Secret approval type (RequireApprovalForEditors, RequireApprovalForOwnersAndEditors)
        [Parameter(ParameterSetName = 'permissions')]
        [Thycotic.PowerShell.Enums.SecretApprovalType]
        $ApprovalType,

        # Default language for all users (English, French, German, Japanese, Korean, Portuguese)
        [Parameter(ParameterSetName = 'userexperience')]
        [Thycotic.PowerShell.Enums.ApplicationLanguage]
        $ApplicationLanguage,

        # Default date format (tab through to see validate set options)
        [Parameter(ParameterSetName = 'userexperience')]
        [ValidateSet('dd/MM/yyyy','yyyy. MM. dd.','dd.MM.yy','d/MM/yyyy','d.M.yyyy',
            'yyyy/M/d','dd.MM.yyyy','yyyy.MM.dd.','d.MM.yyyy','dd/MM/yy','d-M-yyyy',
            'yy.MM.dd','M/d/yyyy','yyyy-MM-dd','yyyy/MM/dd','d. M. yyyy','dd/MM yyyy',
            'yyyy.MM.dd','dd-MM-yy','MM/dd/yyyy','dd-MM-yyyy','d/M/yyyy')]
        [string]
        $DateFormat,

        # Default Role ID assigned to new Users
        [Parameter(ParameterSetName = 'userexperience')]
        [int]
        $DefaultRoleId,

        # Default time format (tab through to see validate set options)
        [Parameter(ParameterSetName = 'userexperience')]
        [ValidateSet('tt h:mm','h:mm:ss tt','H.mm','HH:mm','hh:mm:ss tt','H:mm',
            'HH:mm:ss','hh:mm tt','h:mm.tt','tt hh:mm','H:mm:ss','h:mm tt','HH.mm')]
        [string]
        $TimeFormat,

        # Force Inactivity Timeout
        [Parameter(ParameterSetName = 'userexperience')]
        [switch]
        $ForceInactivityTimeout,

        # Inactivity Timeout in Minutes
        [Parameter(ParameterSetName = 'userexperience')]
        [ValidateRange(1,1440)]
        [int]
        $InactivityTimeout,

        # Require folder for Secrets
        [Parameter(ParameterSetName = 'userexperience')]
        [switch]
        $RequireFolderForSecret,

        # Restrict all recent Passwords on a Secret from being reused
        [Parameter(ParameterSetName = 'userexperience')]
        [switch]
        $PasswordHistoryAll,

        # Number of recent passwords on a Secret that cannot be reused
        [Parameter(ParameterSetName = 'userexperience')]
        [int]
        $PasswordHistory,

        # Number of minutes a Secret can be viewed after entering a comment (without being reprompted)
        [Parameter(ParameterSetName = 'userexperience')]
        [ValidateRange(1,1440)]
        [int]
        $SecretViewInterval,

        # Set Secret Servers default Time Zone (you can use Get-TimeZone -ListAvailable to see the possible IDs for your system)
        [Parameter(ParameterSetName = 'userexperience')]
        [string]
        $TimeZone
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $folderParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'folders'
        $folderParams = @()
        foreach ($f in $folderParamSet) {
            if ($setParams.ContainsKey($f)) {
                $folderParams += $f
            }
        }
        $permParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'permissions'
        $permParams = @()
        foreach ($p in $permParamSet) {
            if ($setParams.ContainsKey($p)) {
                $permParams += $p
            }
        }
        $uxParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'userexperience'
        $uxParams = @()
        foreach ($ux in $uxParamSet) {
            if ($setParams.ContainsKey($ux)) {
                $uxParams += $ux
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'general' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{} }
            if ($folderParams.Count -gt 0) {
                $folderSettings = @{}
                switch ($setParams.Keys) {
                    'EnablePersonalFolders' {
                        $enablePersonal = @{
                            dirty = $true
                            value = [boolean]$EnablePersonalFolders
                        }
                        $folderSettings.Add('enablePersonalFolders',$enablePersonal)
                    }
                    'PersonalFolderName' {
                        $personalName = @{
                            dirty = $true
                            value = [boolean]$PersonalFolderName
                        }
                        $folderSettings.Add('personalFolderName',$personalName)
                    }
                    'PersonalFolderFormat' {
                        $personalFormat = @{
                            dirty = $true
                            value = [string]$PersonalFolderFormat
                        }
                        $folderSettings.Add('PersonalFolderNameOption',$personalFormat)
                    }
                    'PersonalFolderWarning' {
                        $personalWarning = @{
                            dirty = $true
                            value = $PersonalFolderWarning
                        }
                        $folderSettings.Add('personalFolderWarning',$personalWarning)
                    }
                    'PersonalFolderRequireView' {
                        $personalRequireView = @{
                            dirty = $true
                            value = [boolean]$PersonalFolderRequireView
                        }
                        $folderSettings.Add('requireViewFolderPermission',$personalRequireView)
                    }
                    'PersonalFolderEnableWarning' {
                        $enableWarning = @{
                            dirty = $true
                            value = [boolean]$PersonalFolderEnableWarning
                        }
                        $folderSettings.Add('showPersonalFolderWarning',$enableWarning)
                    }
                }
                $setBody.data.Add('folders',$folderSettings)
            }
            if ($permParams.Count -gt 0) {
                $permSettings = @{}
                switch($setParams.Keys) {
                    'AllowDuplicationSecretName' {
                        $allowDuplication = @{
                            dirty = $true
                            value = [boolean]$AllowDuplicationSecretName
                        }
                        $permSettings.Add('allowDuplicationSecretName',$allowDuplication)
                    }
                    'AllowViewNextPassword' {
                        $allowViewNext = @{
                            dirty = $true
                            value = [boolean]$AllowViewNextPassword
                        }
                        $permSettings.Add('allowViewUserToRetrieveAutoChangeNextPassword',$allowViewNext)
                    }
                    'DefaultSecretPermission' {
                        $defaultPermission = @{
                            dirty = $true
                            value = [string]$DefaultSecretPermission
                        }
                        $permSettings.Add('defaultSecretPermissions',$defaultPermission)
                    }
                    'EnableApprovalFromEmail' {
                        $enableApproval = @{
                            dirty = $true
                            value = [boolean]$EnableApprovalFromEmail
                        }
                        $permSettings.Add('enableApprovalFromEmail',$enableApproval)
                    }
                    'ApprovalType' {
                        $approvalType = @{
                            dirty = $true
                            value = [string]$ApprovalType
                        }
                        $permSettings.Add('forceSecretApproval',$approvalType)
                    }
                }
                $setBody.data.Add('permissionOptions',$permSettings)
            }
            if ($uxParams.Count -gt 0) {
                $uxSettings = @{}
                switch ($setParams.Keys) {
                    'ApplicationLanguage' {
                        $defaultLanguage = @{
                            dirty = $true
                            value = $ApplicationLanguage
                        }
                        $uxSettings.Add('applicationLanguage',$defaultLanguage)
                    }
                    'DateFormat' {
                        $dateOptionId = switch ($DateFormat) {
                            'dd/MM/yyyy' { 1 }
                            'yyyy. MM. dd.' { 2 }
                            'dd.MM.yy' { 3 }
                            'd/MM/yyyy' { 4 }
                            'd.M.yyyy' { 5 }
                            'yyyy/M/d' { 6 }
                            'dd.MM.yyyy' { 7 }
                            'yyyy.MM.dd.' { 8 }
                            'd.MM.yyyy' { 9 }
                            'dd/MM/yy' { 10 }
                            'd-M-yyyy' { 11 }
                            'yy.MM.dd' { 12 }
                            'M/d/yyyy' { 13 }
                            'yyyy-MM-dd' { 14 }
                            'yyyy/MM/dd' { 15 }
                            'd. M. yyyy' { 16 }
                            'dd/MM yyyy' { 17 }
                            'yyyy.MM.dd' { 18 }
                            'dd-MM-yy' { 19 }
                            'MM/dd/yyyy' { 20 }
                            'dd-MM-yyyy' { 21 }
                            'd/M/yyyy' { 22 }
                        }
                        $defaultDateFormat = @{
                            dirty = $true
                            value = $dateOptionId
                        }
                        $uxSettings.Add('defaultDateFormat',$defaultDateFormat)
                    }
                    'DefaultRoleId' {
                        $defaultRole = @{
                            dirty = $true
                            value = $DefaultRoleId
                        }
                        $uxSettings.Add('defaultNewUserRoleId',$defaultRole)
                    }
                    'TimeFormat' {
                        $timeOptionId = switch ($TimeFormat) {
                            'tt h:mm' { 1 }
                            'h:mm:ss tt' { 2 }
                            'H.mm' { 3 }
                            'HH:mm' { 4 }
                            'hh:mm:ss tt' { 5 }
                            'H:mm' { 6 }
                            'HH:mm:ss' { 7 }
                            'hh:mm tt' { 8 }
                            'h:mm.tt' { 9 }
                            'tt hh:mm' { 10 }
                            'H:mm:ss' { 11 }
                            'h:mm tt' { 12 }
                            'HH.mm' { 13 }
                        }
                        $defaultTime = @{
                            dirty = $true
                            value = $timeOptionId
                        }
                        $uxSettings.Add('defaultTimeFormat',$defaultTime)
                    }
                    'ForceInactivityTimeout' {
                        $forceTimeout = @{
                            dirty = $true
                            value = [boolean]$ForceInactivityTimeout
                        }
                        $uxSettings.Add('forceInactivityTimeout',$forceTimeout)
                    }
                    'InactivityTimeout' {
                        $forceTimeout = @{
                            dirty = $true
                            value = $InactivityTimeout
                        }
                        $uxSettings.Add('forceInactivityTimeoutMinutes',$forceTimeout)

                        # not sure why this property or argument exists but setting it the same just in case
                        $uiTimeout = @{
                            dirty = $true
                            value = $InactivityTimeout
                        }
                        $uxSettings.Add('uiInactivitySleepMinutes',$uiTimeout)
                    }
                    'RequireFolderForSecret' {
                        $requireFolder = @{
                            dirty = $true
                            value = [boolean]$RequireFolderForSecret
                        }
                        $uxSettings.Add('requireFolderForSecret',$requireFolder)
                    }
                    'PasswordHistoryAll' {
                        $passwordHistory = @{
                            dirty = $true
                            value = [boolean]$PasswordHistoryAll
                        }
                        $uxSettings.Add('secretPasswordHistoryRestrictionAll',$passwordHistory)
                    }
                    'PasswordHistory' {
                        $passwordHistoryCount = @{
                            dirty = $true
                            value = $PasswordHistory
                        }
                        $uxSettings.Add('secretPasswordHistoryRestrictionCount',$passwordHistoryCount)
                    }
                    'SecretViewInterval' {
                        $viewInterval = @{
                            dirty = $true
                            value = $SecretViewInterval
                        }
                        $uxSettings.Add('secretViewIntervalMinutes',$viewInterval)
                    }
                    'TimeZone' {
                        try {
                            $validTimeZoneId = [System.TimeZoneInfo]::FindSystemTimeZoneById($TimeZone).Id
                        } catch {
                            Write-Warning "TimeZone provided [$TimeZone] is not found to be a valid TimeZone ID"
                            return
                        }
                        $zone = @{
                            dirty = $true
                            value = [string]$validTimeZoneId
                        }
                        $uxSettings.Add('serverTimeZoneId',$zone)
                    }
                }
                $setBody.data.Add('userExperience',$uxSettings)
            }
            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose "Setting updated successfully"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}