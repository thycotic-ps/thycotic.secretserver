---
title: Set-TssSecretTemplateFieldOrder
parent: Secret Templates
grand_parent: Commands
---
# Set-TssSecretTemplateFieldOrder

## SYNOPSIS
Set the order of the fields on a secret template

## SYNTAX

```
Set-TssSecretTemplateFieldOrder [-TssSession] <Session> -Id <Int32> -FieldId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sorts the fields of a secret template in the order of the field IDs given.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$fields = Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001 | Sort-Object Name
Set-TssSecretTemplateFieldOrder -TssSession $session -Id 6001 -FieldId $fields.Id
```

Sort the fields of template 6001 by name

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
Aliases: SecretTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FieldId
Secret template field IDs in the order to show them

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FieldIds

Required: True
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

### Thycotic.PowerShell.SecretTemplates.Result
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateFieldOrder](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateFieldOrder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateFieldOrder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateFieldOrder.ps1)
