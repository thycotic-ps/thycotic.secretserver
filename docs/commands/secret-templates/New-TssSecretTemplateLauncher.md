---
title: New-TssSecretTemplateLauncher
parent: Secret Templates
grand_parent: Commands
---
# New-TssSecretTemplateLauncher

## SYNOPSIS
Add a launcher to a secret template

## SYNTAX

```
New-TssSecretTemplateLauncher [-TssSession] <Session> -SecretTemplateId <Int32> -LauncherTypeId <Int32>
 -Field <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a launcher type to a secret template and maps each launcher field to a secret template field, so secrets based on the template offer that launcher.
Get-TssSecretTemplateLauncherStub lists the launcher fields to map.
Its result can be piped to this command once every field has a SecretFieldId the launcher accepts.
Use Set-TssSecretTemplateLauncher to change an existing launcher and Remove-TssSecretTemplateLauncher to remove it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$fields = @(
    [pscustomobject]@{ LauncherTypeFieldId = 5; SecretFieldId = 108 },
    [pscustomobject]@{ LauncherTypeFieldId = 6; SecretFieldId = 110 },
    [pscustomobject]@{ LauncherTypeFieldId = 7; SecretFieldId = 111 },
    [pscustomobject]@{ LauncherTypeFieldId = 22; SecretFieldId = -3; DefaultValue = '22' }
)
New-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -Field $fields
```

Add the PuTTY launcher (type 2) to template 6007: host, password and username from template fields 108, 110 and 111, port 22 as a default value

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$stub = Get-TssSecretTemplateLauncherStub -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
$secretFieldIds = @{ Host = 108; Password = 110; Username = 111; Port = -3 }
foreach ($field in $stub.Fields) { $field.secretFieldId = $secretFieldIds[$field.launcherTypeFieldName] }
($stub.Fields | Where-Object launcherTypeFieldName -EQ 'Port').defaultValue = '22'
$stub | New-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007
```

Start from the stub, map every launcher field by name, and add the launcher to template 6007

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
Secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LauncherTypeId
Launcher type ID to add, as returned by Search-TssSecretTemplateLauncher -LauncherType

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

### -Field
One mapping per launcher field: objects with LauncherTypeFieldId, SecretFieldId and optional DefaultValue properties, such as the Fields of Get-TssSecretTemplateLauncherStub output.
SecretFieldId is a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue).
Each secret template field can be used once.
Review every SecretFieldId of a stub before creating: Secret Server rejects its 0 placeholders and some of its suggested special values

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Fields

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateLauncher.ps1)
