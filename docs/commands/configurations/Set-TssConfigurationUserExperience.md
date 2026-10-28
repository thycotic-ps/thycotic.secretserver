---
title: Set-TssConfigurationUserExperience
parent: Configurations
grand_parent: Commands
---
# Set-TssConfigurationUserExperience

## SYNOPSIS
Set the user experience configuration

## SYNTAX

```
Set-TssConfigurationUserExperience [-TssSession] <Session> [-ApplicationLanguage <Int32>]
 [-ApprovalAllowApproverChangeRequestTime] [-ApprovalAllowCustomDuration]
 [-ApprovalAllowedMinuteDurations <Int32[]>] [-ApprovalMaxRequestMinutes <Int32>]
 [-CheckoutNotificationThreshold <Int32>] [-DefaultDateFormat <Int32>] [-DefaultNewUserRoleId <Int32>]
 [-DefaultTimeFormat <Int32>] [-DisableLegacyBookmarkPages] [-EnableIconGathering]
 [-EnableRequestForceCheckout] [-EnableSecretCheckOutExtension] [-ForceInactivityTimeout]
 [-ForceInactivityTimeoutMinutes <Int32>] [-IncludeSessionInfoOnAllSecretAudits]
 [-MaxCheckOutExtensionInMinutes <Int32>] [-PasswordMaskTimeout <Int32>] [-RequireFolderForSecret]
 [-SearchDelayMs <Int32>] [-SecretCommentIntervalMinutes <Int32>]
 [-SecretPasswordDisplayedIntervalMinutes <Int32>] [-SecretPasswordHistoryRestrictionAll]
 [-SecretPasswordHistoryRestrictionCount <Int32>] [-SecretViewIntervalMinutes <Int32>]
 [-SeparateCheckoutAndCommentAction] [-SeparateSecretAuditComment] [-ServerTimeZoneId <String>]
 [-ShowSecretIcons] [-UiInactivitySleepMinutes <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the user experience configuration (inactivity timeouts, secret view and comment intervals, checkout and access request options, display defaults) and returns the updated configuration.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Name:$false turns a setting off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationUserExperience -TssSession $session -ForceInactivityTimeout -ForceInactivityTimeoutMinutes 30
```

Log out users after 30 minutes of inactivity

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationUserExperience -TssSession $session -RequireFolderForSecret
```

Require a folder for every new secret

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for authentication

```yaml
Type: Session
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ApplicationLanguage
Default language id for all users

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApprovalAllowApproverChangeRequestTime
When true, the approver is able to adjust the access request duration, start, and end date

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApprovalAllowCustomDuration
Access requests can have a custom start and end date

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApprovalAllowedMinuteDurations
Defines which options are allowed for duration when creating access requests

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApprovalMaxRequestMinutes
Maximum number of minutes that can be requested for an access request.
Null means no limit

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CheckoutNotificationThreshold
Percentage of secret checkout time elapsed when checkout notification will be sent

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultDateFormat
Default date format id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultNewUserRoleId
Role id assigned to new users

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultTimeFormat
Default time format id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableLegacyBookmarkPages
Indicates whether or not the legacy web password filler and bookmark pages are active.
By default they are enabled and will be disabled in a future release and eventually removed

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableIconGathering
Enables gathering of favicons for secret url values

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableRequestForceCheckout
Enables a user who does not have the force checkout permission to request a force checkout for secret

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableSecretCheckOutExtension
Enables users to extend secret check out sessions

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceInactivityTimeout
Logout users that are inactive

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceInactivityTimeoutMinutes
Logout users that are inactive for this many minutes

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSessionInfoOnAllSecretAudits
When true, if a secret has require comment enabled that ticket number, if entered, will be applied to every audit on the secret during that session

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxCheckOutExtensionInMinutes
Maximum amount of time a secret check out can be extended in minutes

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordMaskTimeout
After this time period elapsed a password field will hide this password and remove it from browser memory.
Viewing the password again after this time period will require a request for the password from the server.
Zero or null will never flip or clear the password from the browser

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireFolderForSecret
Secrets must be created within a folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchDelayMs
This controls the delay, in milliseconds, until the search is executed by the global search in the header

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretCommentIntervalMinutes
The number of minutes which a Secret can be viewed after entering a comment

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPasswordDisplayedIntervalMinutes
The interval between secret password displayed audit creation when viewing a secret's password field(s)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPasswordHistoryRestrictionAll
No duplicate passwords on a Secret

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPasswordHistoryRestrictionCount
The number of recently used passwords on a Secret that cannot be used

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretViewIntervalMinutes
The interval between secret view audit creation

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SeparateCheckoutAndCommentAction
When true the action menu in the secret grid will show checkout and comment as separate actions

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SeparateSecretAuditComment
When true the secret audit log will have a separate comment entry which allows comment to happen and not view.
View will only happen if the secret is actually viewed

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServerTimeZoneId
The timezone that the server shows by default and when job scheduling runs

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowSecretIcons
Enables display of secret icons

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UiInactivitySleepMinutes
How long until the UI will go inactive and stop polling for updates

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.ConfigurationUserExperience
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserExperience](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserExperience)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserExperience.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserExperience.ps1)
