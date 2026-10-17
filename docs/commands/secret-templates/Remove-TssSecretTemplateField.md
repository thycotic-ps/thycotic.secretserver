---
title: Remove-TssSecretTemplateField
parent: Secret Templates
grand_parent: Commands
---
# Remove-TssSecretTemplateField

## SYNOPSIS
Remove a field from a secret template

## SYNTAX

```
Remove-TssSecretTemplateField [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disables (deactivates) a secret template field.
Secret Server keeps the field record.
Returns the disabled field.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretTemplateField -TssSession $session -Id 312
```

Disable secret template field 312

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
Secret template field ID to disable

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TemplateFieldId, SecretTemplateFieldId

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

### Thycotic.PowerShell.SecretTemplates.Field
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateField.ps1)
