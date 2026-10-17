---
title: Set-TssSecretTemplateLauncher
parent: Secret Templates
grand_parent: Commands
---
# Set-TssSecretTemplateLauncher

## SYNOPSIS
Set the launcher settings of a secret template

## SYNTAX

```
Set-TssSecretTemplateLauncher [-TssSession] <Session> -LauncherTypeId <Int32> -SecretTemplateId <Int32>
 [-AllowList <Int32>] [-ConnectAsCommand <String>] [-ConnectAsCommandResponse <String>]
 [-ConnectAsTimeoutInSeconds <Int32>] [-DenyList <Int32>] [-ExpectedPromptEnding <String>] [-Field <Object[]>]
 [-IncludeMachinesFromDependencies] [-LineEnding <String>] [-RestrictAs <Int32>]
 [-RestrictBySecretField <Int32>] [-RestrictUserInput] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the settings of a launcher on a secret template: field mappings, input restrictions and connect-as settings.
Only the parameters you pass are changed.
Returns the updated launcher.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -RestrictUserInput:$false
```

Let users of launcher type 2 on template 6007 connect to any host

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$launcher = Get-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
($launcher.Fields | Where-Object launcherTypeFieldName -EQ 'Port').defaultValue = '2222'
Set-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -Field $launcher.Fields
```

Change the default port of launcher type 2 on template 6007 to 2222, keeping the other field mappings

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

### -LauncherTypeId
Launcher type ID of the launcher to change

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretTemplateId
Secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowList
Secret template field ID that holds the allow list of hosts

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

### -ConnectAsCommand
Command the SSH proxy runs to switch user, such as 'su - $USERNAME'

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

### -ConnectAsCommandResponse
Prompt the connect-as command expects and the field token to answer it with

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

### -ConnectAsTimeoutInSeconds
Timeout of the connect-as command, in seconds

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

### -DenyList
Secret template field ID that holds the deny list of hosts

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

### -ExpectedPromptEnding
Character that ends the server prompt, such as $ or #

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

### -Field
Launcher field mappings that replace the current ones: objects with LauncherTypeFieldId, SecretFieldId and optional DefaultValue properties, such as the Fields of Get-TssSecretTemplateLauncher output.
SecretFieldId is a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Fields

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeMachinesFromDependencies
Add the machines of secret dependencies to the allowed hosts, or not with -IncludeMachinesFromDependencies:$false

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

### -LineEnding
Line ending sent after the connect-as command

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

### -RestrictAs
How user input is restricted, as in the RestrictAs value of Get-TssSecretTemplateLauncher

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

### -RestrictBySecretField
Secret template field ID whose value restricts the hosts a user can connect to

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

### -RestrictUserInput
Restrict the hosts a user can enter, or allow any host with -RestrictUserInput:$false.
Enabling it requires a launcher field mapped to user input (-2) and one of -AllowList, -DenyList, -RestrictAs or -RestrictBySecretField, because Secret Server derives the restriction from those settings

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

### Thycotic.PowerShell.SecretTemplates.Launcher
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateLauncher.ps1)
