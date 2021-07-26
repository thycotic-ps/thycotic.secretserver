# New-TssSecretTemplate

## SYNOPSIS
Create a new Secret Template

## SYNTAX

### newcopy
```
New-TssSecretTemplate [-TssSession] <Session> -Template <Template> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### new
```
New-TssSecretTemplate [-TssSession] <Session> -TemplateName <String> -TemplateField <Field[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new Secret Template

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
$copyTemplate = Get-TssSecretTemplate -TssSession $session -Id 6042
$copyTemplate.Name = 'Test Template - copy of 6042'
New-TssSecretTemplate -TssSession $session -Template $copyTemplate
```

Gets the Secret Template 6042, changing the name of the Template and then creating it

### EXAMPLE 2
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
$fields = @()
$fields += New-TssSecretTemplateField -FieldName 'Field 1 Username' -Searchable
$fields += New-TssSecretTemplateField -FieldName 'Field 2 Password' -Type Password
$fields += New-TssSecretTemplateField -FieldName 'Field 3 URL' -Type Url -Searchable
New-TssSecretTemplate -TssSession $session -TemplateName 'Test Template 42' -TemplateField $fields
```

Creates a new template named "Test Template 42" with 3 fields

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

### -Template
Template Stub object

```yaml
Type: Template
Parameter Sets: newcopy
Aliases: TemplateStub

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TemplateName
Template Name

```yaml
Type: String
Parameter Sets: new
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateField
Fields, use New-TssSecretTemplateField to build this object

```yaml
Type: Field[]
Parameter Sets: new
Aliases: Fields

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

### Thycotic.PowerShell.SecretTemplates.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplate.ps1)

