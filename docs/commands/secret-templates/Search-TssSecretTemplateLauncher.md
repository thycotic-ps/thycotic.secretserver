---
title: Search-TssSecretTemplateLauncher
parent: Secret Templates
grand_parent: Commands
---
# Search-TssSecretTemplateLauncher

## SYNOPSIS
Search the launchers of a secret template, or the available launcher types

## SYNTAX

### Default (Default)
```
Search-TssSecretTemplateLauncher [-TssSession] <Session> -SecretTemplateId <Int32>
 [<CommonParameters>]
```

### LauncherType
```
Search-TssSecretTemplateLauncher [-TssSession] <Session> [-LauncherType] [-ApplicationName <String>]
 [-IncludeInactive] [-IncludeSystemLaunchers] [<CommonParameters>]
```

## DESCRIPTION
Returns the launchers configured on a secret template, with their field mappings, input restrictions and connect-as settings.
-SecretTemplateId is required for this search.
With -LauncherType, returns the launcher types available on the Secret Server instead, such as PuTTY or Remote Desktop, with their IDs.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007
```

Get the launchers configured on template 6007

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateLauncher -TssSession $session -LauncherType -IncludeInactive
```

List every launcher type, inactive ones included

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

### -SecretTemplateId
Secret template ID whose launchers to return

```yaml
Type: Int32
Parameter Sets: Default
Aliases: TemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LauncherType
Return the available launcher types instead of the launchers of a template

```yaml
Type: SwitchParameter
Parameter Sets: LauncherType
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName
Return only launcher types for this application name

```yaml
Type: String
Parameter Sets: LauncherType
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive launcher types

```yaml
Type: SwitchParameter
Parameter Sets: LauncherType
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSystemLaunchers
Include system launcher types

```yaml
Type: SwitchParameter
Parameter Sets: LauncherType
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.LauncherSummary[]
### Thycotic.PowerShell.SecretTemplates.LauncherType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateLauncher.ps1)
