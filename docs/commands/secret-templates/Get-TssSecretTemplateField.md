---
title: Get-TssSecretTemplateField
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplateField

## SYNOPSIS
Get secret template fields

## SYNTAX

### Default (Default)
```
Get-TssSecretTemplateField [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Template
```
Get-TssSecretTemplateField [-TssSession] <Session> -SecretTemplateId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get a secret template field by its field ID, with its data type, dropdown options and permission settings.
With -SecretTemplateId, get the field labels of a secret template instead.
Basic users can read the labels.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateField -TssSession $session -Id 108
```

Get secret template field 108

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateField -TssSession $session -SecretTemplateId 6007
```

Get the field labels of template 6007

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
Secret template field ID

```yaml
Type: Int32[]
Parameter Sets: Default
Aliases: SecretFieldId, FieldId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretTemplateId
Secret template ID whose field labels to get

```yaml
Type: Int32[]
Parameter Sets: Template
Aliases: TemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.FieldDetail
### Thycotic.PowerShell.SecretTemplates.FieldLabel
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateField.ps1)
