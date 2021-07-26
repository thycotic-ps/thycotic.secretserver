# Update-TssSecretTemplateField

## SYNOPSIS
Update a field on a Secret Template

## SYNTAX

```
Update-TssSecretTemplateField [-TssSession] <Session> [-TemplateId] <Int32> [-Field <Field>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a field on a Secret Template

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$template = Get-TssSecret -TssSession $session -TemplateId 6025
$pwdField = $template.GetField('password')
$pwdField.IsRequired = $true
Update-TssSecretTemplateField -TssSession $session -TemplateId 6026 -Field $pwdField
```

Gets current Password field on Template 6025 and updates IsRequired to be true

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

### -TemplateId
Secret Template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Field
Secret Template Field (see example)

```yaml
Type: Field
Parameter Sets: (All)
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

### Thycotic.PowerShell.SecretTemplates.Field
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplateField.ps1)

