---
title: Update-TssSecretTemplatePasswordType
parent: Secret Templates
grand_parent: Commands
---
# Update-TssSecretTemplatePasswordType

## SYNOPSIS
Assign a password type to a secret template, replacing its field mappings

## SYNTAX

```
Update-TssSecretTemplatePasswordType [-TssSession] <Session> -Id <Int32> -PasswordTypeId <Int32>
 -FieldMapping <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Assigns a password type (password changer) to a secret template together with the mapping of every template field to a password type field.
The request replaces the current assignment.
-FieldMapping must have one entry for each field of the template; map the fields the password type does not use to -1.
To change single settings, such as heartbeat or remote password changing intervals, use Set-TssSecretTemplatePasswordType instead.
Returns the secret template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$mapping = @{ }
(Get-TssSecretTemplate -TssSession $session -Id 6007).Fields | ForEach-Object { $mapping[$_.SecretTemplateFieldId] = -1 }
$mapping[108] = 26
$mapping[110] = 27
$mapping[111] = 28
Update-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -PasswordTypeId 9 -FieldMapping $mapping
```

Assign password type 9 to template 6007, map its machine, password and username fields, and leave the other fields unmapped

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

### -PasswordTypeId
Password type (password changer) ID to assign

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldMapping
Mapping of every secret template field ID (keys) to a password type field ID, or -1 for fields the password type does not use (values)

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplatePasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplatePasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplatePasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplatePasswordType.ps1)
