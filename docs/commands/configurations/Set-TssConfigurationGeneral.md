# Set-TssConfigurationGeneral

## SYNOPSIS
Set general configuration

## SYNTAX

### folders
```
Set-TssConfigurationGeneral [-TssSession] <Session> [-EnablePersonalFolders] [-PersonalFolderName]
 [-PersonalFolderFormat <PersonalFolderNameOption>] [-PersonalFolderWarning <String>]
 [-PersonalFolderRequireView] [-PersonalFolderEnableWarning] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### permissions
```
Set-TssConfigurationGeneral [-TssSession] <Session> [-AllowDuplicationSecretName] [-AllowViewNextPassword]
 [-DefaultSecretPermission <SecretPermissionType>] [-EnableApprovalFromEmail]
 [-ApprovalType <SecretApprovalType>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### userexperience
```
Set-TssConfigurationGeneral [-TssSession] <Session> [-ApplicationLanguage <ApplicationLanguage>]
 [-DateFormat <String>] [-DefaultRoleId <Int32>] [-TimeFormat <String>] [-ForceInactivityTimeout]
 [-InactivityTimeout <Int32>] [-RequireFolderForSecret] [-PasswordHistoryAll] [-PasswordHistory <Int32>]
 [-SecretViewInterval <Int32>] [-TimeZone <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set general configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationGeneral -TssSession $session -EnablePersonalFolders:$false
```

Disable Personal Folders

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationGeneral -TssSession $session -TimeZone (Get-TimeZone).Id
```

Set Secret Server Time Zone to the current user's Windows' default TimeZone.

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

### -EnablePersonalFolders
Enable Personal Folders

```yaml
Type: SwitchParameter
Parameter Sets: folders
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalFolderName
Personal Folder Name

```yaml
Type: SwitchParameter
Parameter Sets: folders
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalFolderFormat
Personal Folder Name Format (DisplayName, UsernameAndDomain)

```yaml
Type: PersonalFolderNameOption
Parameter Sets: folders
Aliases:
Accepted values: DisplayName, UsernameAndDomain

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalFolderWarning
Personal Folder warning message

```yaml
Type: String
Parameter Sets: folders
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalFolderRequireView
Personal Folder Require View Permission

```yaml
Type: SwitchParameter
Parameter Sets: folders
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalFolderEnableWarning
Show Personal Folder warning message

```yaml
Type: SwitchParameter
Parameter Sets: folders
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowDuplicationSecretName
Allow duplicate secret names

```yaml
Type: SwitchParameter
Parameter Sets: permissions
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowViewNextPassword
Allow View Rights on Secret to read Next Password for RPC

```yaml
Type: SwitchParameter
Parameter Sets: permissions
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultSecretPermission
Default permissions to apply when Secret is created (InheritsPermissions, CopyFromFolder, OnlyAllowCreator)

```yaml
Type: SecretPermissionType
Parameter Sets: permissions
Aliases:
Accepted values: InheritsPermissions, CopyFromFolder, OnlyAllowCreator

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableApprovalFromEmail
Allow approval for access from email

```yaml
Type: SwitchParameter
Parameter Sets: permissions
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApprovalType
Force Secret approval type (RequireApprovalForEditors, RequireApprovalForOwnersAndEditors)

```yaml
Type: SecretApprovalType
Parameter Sets: permissions
Aliases:
Accepted values: RequireApprovalForEditors, RequireApprovalForOwnersAndEditors

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationLanguage
Default language for all users (English, French, German, Japanese, Korean, Portuguese)

```yaml
Type: ApplicationLanguage
Parameter Sets: userexperience
Aliases:
Accepted values: German, English, French, Japanese, Korean, Portuguese

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateFormat
Default date format (tab through to see validate set options)

```yaml
Type: String
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultRoleId
Default Role ID assigned to new Users

```yaml
Type: Int32
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeFormat
Default time format (tab through to see validate set options)

```yaml
Type: String
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceInactivityTimeout
Force Inactivity Timeout

```yaml
Type: SwitchParameter
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InactivityTimeout
Inactivity Timeout in Minutes

```yaml
Type: Int32
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireFolderForSecret
Require folder for Secrets

```yaml
Type: SwitchParameter
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordHistoryAll
Restrict all recent Passwords on a Secret from being reused

```yaml
Type: SwitchParameter
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordHistory
Number of recent passwords on a Secret that cannot be reused

```yaml
Type: Int32
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretViewInterval
Number of minutes a Secret can be viewed after entering a comment (without being reprompted)

```yaml
Type: Int32
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZone
Set Secret Servers default Time Zone (you can use Get-TimeZone -ListAvailable to see the possible IDs for your system)

```yaml
Type: String
Parameter Sets: userexperience
Aliases:

Required: False
Position: Named
Default value: None
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationGeneral](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationGeneral)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationGeneral.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationGeneral.ps1)

