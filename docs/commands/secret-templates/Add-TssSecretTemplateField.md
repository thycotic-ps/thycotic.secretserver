# Add-TssSecretTemplateField

## SYNOPSIS
Add a new field to a Secret Template

## SYNTAX

```
Add-TssSecretTemplateField [-TssSession] <Session> [-Id] <Int32[]> [-Field] <Field> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Add a new field to a Secret Template

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
(Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
$newField = New-TssSecretTemplateField -FieldName 'Additional Field' -Searchable
Add-TssSecretTemplateField -TssSession $session -Id 6042 -Field $newField
(Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
```

Output the current fields for Secret Template 6042, create a new field named "Additional Field" that is searchable and add to the Secret Template 6042

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
Template Stub object

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TemplateId

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Field
Fields, use New-TssSecretTemplateField to build this object

```yaml
Type: Field
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Add-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Add-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Add-TssSecretTemplateField](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Add-TssSecretTemplateField)

