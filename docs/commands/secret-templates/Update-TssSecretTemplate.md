---
title: Update-TssSecretTemplate
parent: Secret Templates
grand_parent: Commands
---
# Update-TssSecretTemplate

## SYNOPSIS
Update the settings of a secret template

## SYNTAX

```
Update-TssSecretTemplate [-TssSession] <Session> -Id <Int32> [-Active] [-DaysToShowAdExpiration <Int32>]
 [-Description <String>] [-ExpirationChangeRequiredOnFieldId <Int32>] [-ExpirationDays <Int32>]
 [-ExpirationEnabled] [-IconName <String>] [-Name <String>] [-NamePattern <String>]
 [-NamePatternErrorMessage <String>] [-OneTimePasswordDuration <Int32>] [-OneTimePasswordEnabled]
 [-OneTimePasswordHash <String>] [-OneTimePasswordLength <Int32>]
 [-PermissionRequiredToEditPasswordChangeConfiguration <String>] [-SaveAllNameHistory]
 [-SecretNameHistoryLength <Int32>] [-SshKeyAlgorithm <String>] [-SshKeyFormat <String>] [-SshKeySize <String>]
 [-TicketSystemScriptArgs <String>] [-ValidatePasswordRequirementsOnCreate]
 [-ValidatePasswordRequirementsOnEdit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes one or more settings of a secret template, such as name, description, secret name pattern, expiration, one-time password and SSH key settings.
Only the parameters you pass are changed.
Set-TssSecretTemplate only changes the active state; this command covers the full set of template settings.
Returns the updated template detail.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretTemplate -TssSession $session -Id 6001 -Description 'Domain service accounts' -NamePattern '^svc-' -NamePatternErrorMessage 'Secret names must start with svc-'
```

Change the description of template 6001 and require secret names to start with svc-

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

### -Id
Secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretTemplateId, TemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Set the template active, or inactive with -Active:$false

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

### -DaysToShowAdExpiration
Number of days before an Active Directory password expires to start showing a warning

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

### -Description
Template description

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

### -ExpirationChangeRequiredOnFieldId
Secret Template Field ID that will require change on Expiration

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

### -ExpirationDays
Number of days after which secrets expire.
Applied when ExpirationChangeRequiredOnFieldId is a valid field

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

### -ExpirationEnabled
Expiration enabled

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

### -IconName
Icon name to show for secret

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

### -Name
Template name

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

### -NamePattern
Regex pattern enforced on secret names

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

### -NamePatternErrorMessage
Error shown when name doesn't match pattern

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

### -OneTimePasswordDuration
Duration in seconds that the One Time Password is valid, updated when one time password is enabled

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

### -OneTimePasswordEnabled
One time password enabled

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

### -OneTimePasswordHash
Hash algorithm used to generate the one-time password.
Applied when one-time passwords are enabled

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

### -OneTimePasswordLength
Length of the generated One Time Password, updated when one time password is enabled

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

### -PermissionRequiredToEditPasswordChangeConfiguration
Permission required to edit password change configuration

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

### -SaveAllNameHistory
Indicates that all Secret Name history will be saved

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

### -SecretNameHistoryLength
The number of Secret Names to be saved.
If SaveAllNameHistory is true, this will be ignored

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

### -SshKeyAlgorithm
Algorithm of the SSH Key, updated when the template contains a private SSH Key

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

### -SshKeyFormat
Format of the SSH Key, updated when the template contains a private SSH Key

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

### -SshKeySize
Size of the SSH Key in bits, updated when the template contains a private SSH Key

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

### -TicketSystemScriptArgs
A list of field slugs that will be passed as parameters to a PowerShell ticket system

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

### -ValidatePasswordRequirementsOnCreate
Validate password requirements on create

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

### -ValidatePasswordRequirementsOnEdit
Validate password requirements on edit

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

### Thycotic.PowerShell.SecretTemplates.Detail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplate.ps1)
