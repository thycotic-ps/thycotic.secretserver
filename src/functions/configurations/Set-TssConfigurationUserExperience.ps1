function Set-TssConfigurationUserExperience {
    <#
    .SYNOPSIS
    Set the user experience configuration

    .DESCRIPTION
    Updates the user experience configuration (inactivity timeouts, secret view and comment intervals, checkout and access request options, display defaults) and returns the updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ApplicationLanguage
    Default language id for all users

    .PARAMETER ApprovalAllowApproverChangeRequestTime
    When true, the approver is able to adjust the access request duration, start, and end date

    .PARAMETER ApprovalAllowCustomDuration
    Access requests can have a custom start and end date

    .PARAMETER ApprovalAllowedMinuteDurations
    Defines which options are allowed for duration when creating access requests

    .PARAMETER ApprovalMaxRequestMinutes
    Maximum number of minutes that can be requested for an access request. Null means no limit

    .PARAMETER CheckoutNotificationThreshold
    Percentage of secret checkout time elapsed when checkout notification will be sent

    .PARAMETER DefaultDateFormat
    Default date format id

    .PARAMETER DefaultNewUserRoleId
    Role id assigned to new users

    .PARAMETER DefaultTimeFormat
    Default time format id

    .PARAMETER DisableLegacyBookmarkPages
    Indicates whether or not the legacy web password filler and bookmark pages are active. By default they are enabled and will be disabled in a future release and eventually removed

    .PARAMETER EnableIconGathering
    Enables gathering of favicons for secret url values

    .PARAMETER EnableRequestForceCheckout
    Enables a user who does not have the force checkout permission to request a force checkout for secret

    .PARAMETER EnableSecretCheckOutExtension
    Enables users to extend secret check out sessions

    .PARAMETER ForceInactivityTimeout
    Logout users that are inactive

    .PARAMETER ForceInactivityTimeoutMinutes
    Logout users that are inactive for this many minutes

    .PARAMETER IncludeSessionInfoOnAllSecretAudits
    When true, if a secret has require comment enabled that ticket number, if entered, will be applied to every audit on the secret during that session

    .PARAMETER MaxCheckOutExtensionInMinutes
    Maximum amount of time a secret check out can be extended in minutes

    .PARAMETER PasswordMaskTimeout
    After this time period elapsed a password field will hide this password and remove it from browser memory. Viewing the password again after this time period will require a request for the password from the server. Zero or null will never flip or clear the password from the browser

    .PARAMETER RequireFolderForSecret
    Secrets must be created within a folder

    .PARAMETER SearchDelayMs
    This controls the delay, in milliseconds, until the search is executed by the global search in the header

    .PARAMETER SecretCommentIntervalMinutes
    The number of minutes which a Secret can be viewed after entering a comment

    .PARAMETER SecretPasswordDisplayedIntervalMinutes
    The interval between secret password displayed audit creation when viewing a secret's password field(s)

    .PARAMETER SecretPasswordHistoryRestrictionAll
    No duplicate passwords on a Secret

    .PARAMETER SecretPasswordHistoryRestrictionCount
    The number of recently used passwords on a Secret that cannot be used

    .PARAMETER SecretViewIntervalMinutes
    The interval between secret view audit creation

    .PARAMETER SeparateCheckoutAndCommentAction
    When true the action menu in the secret grid will show checkout and comment as separate actions

    .PARAMETER SeparateSecretAuditComment
    When true the secret audit log will have a separate comment entry which allows comment to happen and not view. View will only happen if the secret is actually viewed

    .PARAMETER ServerTimeZoneId
    The timezone that the server shows by default and when job scheduling runs

    .PARAMETER ShowSecretIcons
    Enables display of secret icons

    .PARAMETER UiInactivitySleepMinutes
    How long until the UI will go inactive and stop polling for updates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationUserExperience -TssSession $session -ForceInactivityTimeout -ForceInactivityTimeoutMinutes 30

    Log out users after 30 minutes of inactivity

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationUserExperience -TssSession $session -RequireFolderForSecret

    Require a folder for every new secret

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserExperience

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserExperience.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Setting names from the REST model, not a credential pair')]
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ConfigurationUserExperience')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $ApplicationLanguage,

        [switch]
        $ApprovalAllowApproverChangeRequestTime,

        [switch]
        $ApprovalAllowCustomDuration,

        [int[]]
        $ApprovalAllowedMinuteDurations,

        [int]
        $ApprovalMaxRequestMinutes,

        [int]
        $CheckoutNotificationThreshold,

        [int]
        $DefaultDateFormat,

        [int]
        $DefaultNewUserRoleId,

        [int]
        $DefaultTimeFormat,

        [switch]
        $DisableLegacyBookmarkPages,

        [switch]
        $EnableIconGathering,

        [switch]
        $EnableRequestForceCheckout,

        [switch]
        $EnableSecretCheckOutExtension,

        [switch]
        $ForceInactivityTimeout,

        [int]
        $ForceInactivityTimeoutMinutes,

        [switch]
        $IncludeSessionInfoOnAllSecretAudits,

        [int]
        $MaxCheckOutExtensionInMinutes,

        [int]
        $PasswordMaskTimeout,

        [switch]
        $RequireFolderForSecret,

        [int]
        $SearchDelayMs,

        [int]
        $SecretCommentIntervalMinutes,

        [int]
        $SecretPasswordDisplayedIntervalMinutes,

        [switch]
        $SecretPasswordHistoryRestrictionAll,

        [int]
        $SecretPasswordHistoryRestrictionCount,

        [int]
        $SecretViewIntervalMinutes,

        [switch]
        $SeparateCheckoutAndCommentAction,

        [switch]
        $SeparateSecretAuditComment,

        [string]
        $ServerTimeZoneId,

        [switch]
        $ShowSecretIcons,

        [int]
        $UiInactivitySleepMinutes
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'user-experience' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ApplicationLanguage' {
                    $body.data.Add('applicationLanguage', @{ dirty = $true; value = $ApplicationLanguage })
                }
                'ApprovalAllowApproverChangeRequestTime' {
                    $body.data.Add('approvalAllowApproverChangeRequestTime', @{ dirty = $true; value = [boolean]$ApprovalAllowApproverChangeRequestTime })
                }
                'ApprovalAllowCustomDuration' {
                    $body.data.Add('approvalAllowCustomDuration', @{ dirty = $true; value = [boolean]$ApprovalAllowCustomDuration })
                }
                'ApprovalAllowedMinuteDurations' {
                    $body.data.Add('approvalAllowedMinuteDurations', @{ dirty = $true; value = $ApprovalAllowedMinuteDurations })
                }
                'ApprovalMaxRequestMinutes' {
                    $body.data.Add('approvalMaxRequestMinutes', @{ dirty = $true; value = $ApprovalMaxRequestMinutes })
                }
                'CheckoutNotificationThreshold' {
                    $body.data.Add('checkoutNotificationThreshold', @{ dirty = $true; value = $CheckoutNotificationThreshold })
                }
                'DefaultDateFormat' {
                    $body.data.Add('defaultDateFormat', @{ dirty = $true; value = $DefaultDateFormat })
                }
                'DefaultNewUserRoleId' {
                    $body.data.Add('defaultNewUserRoleId', @{ dirty = $true; value = $DefaultNewUserRoleId })
                }
                'DefaultTimeFormat' {
                    $body.data.Add('defaultTimeFormat', @{ dirty = $true; value = $DefaultTimeFormat })
                }
                'DisableLegacyBookmarkPages' {
                    $body.data.Add('disableLegacyBookmarkPages', @{ dirty = $true; value = [boolean]$DisableLegacyBookmarkPages })
                }
                'EnableIconGathering' {
                    $body.data.Add('enableIconGathering', @{ dirty = $true; value = [boolean]$EnableIconGathering })
                }
                'EnableRequestForceCheckout' {
                    $body.data.Add('enableRequestForceCheckout', @{ dirty = $true; value = [boolean]$EnableRequestForceCheckout })
                }
                'EnableSecretCheckOutExtension' {
                    $body.data.Add('enableSecretCheckOutExtension', @{ dirty = $true; value = [boolean]$EnableSecretCheckOutExtension })
                }
                'ForceInactivityTimeout' {
                    $body.data.Add('forceInactivityTimeout', @{ dirty = $true; value = [boolean]$ForceInactivityTimeout })
                }
                'ForceInactivityTimeoutMinutes' {
                    $body.data.Add('forceInactivityTimeoutMinutes', @{ dirty = $true; value = $ForceInactivityTimeoutMinutes })
                }
                'IncludeSessionInfoOnAllSecretAudits' {
                    $body.data.Add('includeSessionInfoOnAllSecretAudits', @{ dirty = $true; value = [boolean]$IncludeSessionInfoOnAllSecretAudits })
                }
                'MaxCheckOutExtensionInMinutes' {
                    $body.data.Add('maxCheckOutExtensionInMinutes', @{ dirty = $true; value = $MaxCheckOutExtensionInMinutes })
                }
                'PasswordMaskTimeout' {
                    $body.data.Add('passwordMaskTimeout', @{ dirty = $true; value = $PasswordMaskTimeout })
                }
                'RequireFolderForSecret' {
                    $body.data.Add('requireFolderForSecret', @{ dirty = $true; value = [boolean]$RequireFolderForSecret })
                }
                'SearchDelayMs' {
                    $body.data.Add('searchDelayMs', @{ dirty = $true; value = $SearchDelayMs })
                }
                'SecretCommentIntervalMinutes' {
                    $body.data.Add('secretCommentIntervalMinutes', @{ dirty = $true; value = $SecretCommentIntervalMinutes })
                }
                'SecretPasswordDisplayedIntervalMinutes' {
                    $body.data.Add('secretPasswordDisplayedIntervalMinutes', @{ dirty = $true; value = $SecretPasswordDisplayedIntervalMinutes })
                }
                'SecretPasswordHistoryRestrictionAll' {
                    $body.data.Add('secretPasswordHistoryRestrictionAll', @{ dirty = $true; value = [boolean]$SecretPasswordHistoryRestrictionAll })
                }
                'SecretPasswordHistoryRestrictionCount' {
                    $body.data.Add('secretPasswordHistoryRestrictionCount', @{ dirty = $true; value = $SecretPasswordHistoryRestrictionCount })
                }
                'SecretViewIntervalMinutes' {
                    $body.data.Add('secretViewIntervalMinutes', @{ dirty = $true; value = $SecretViewIntervalMinutes })
                }
                'SeparateCheckoutAndCommentAction' {
                    $body.data.Add('separateCheckoutAndCommentAction', @{ dirty = $true; value = [boolean]$SeparateCheckoutAndCommentAction })
                }
                'SeparateSecretAuditComment' {
                    $body.data.Add('separateSecretAuditComment', @{ dirty = $true; value = [boolean]$SeparateSecretAuditComment })
                }
                'ServerTimeZoneId' {
                    $body.data.Add('serverTimeZoneId', @{ dirty = $true; value = $ServerTimeZoneId })
                }
                'ShowSecretIcons' {
                    $body.data.Add('showSecretIcons', @{ dirty = $true; value = [boolean]$ShowSecretIcons })
                }
                'UiInactivitySleepMinutes' {
                    $body.data.Add('uiInactivitySleepMinutes', @{ dirty = $true; value = $UiInactivitySleepMinutes })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration user experience", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationUserExperience request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ConfigurationUserExperience](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ConfigurationUserExperience]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
