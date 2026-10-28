---
title: New-TssSecretTemplateExtendedMapping
parent: Secret Templates
grand_parent: Commands
---
# New-TssSecretTemplateExtendedMapping

## SYNOPSIS
Add an extended mapping to a secret template

## SYNTAX

```
New-TssSecretTemplateExtendedMapping [-TssSession] <Session> -ExtendedTypeId <Int32> -SecretTemplateId <Int32>
 -Fields <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Maps the fields of an extended type, such as an SSH key or certificate type, onto fields of a secret template.
Get-TssSecretTemplateExtendedMappingStub returns the extended fields to assign.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6 -ExtendedTypeId 1 -Fields @{ ExtendedFieldId = 1; SecretFieldId = 108 }, @{ ExtendedFieldId = 2; SecretFieldId = 109 }
```

Maps extended fields 1 and 2 of extended type 1 onto fields 108 and 109 of secret template 6

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

### -ExtendedTypeId
Extended type ID (Search-TssSecretTemplateExtendedType lists them)

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
Aliases: SecretTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Fields
Field assignments: objects or hashtables with ExtendedFieldId (a field of the extended type) and SecretFieldId (a field of the secret template).
The Fields of Get-TssSecretTemplateExtendedMappingStub output can be passed after SecretFieldId is filled in

```yaml
Type: Object[]
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

### Thycotic.PowerShell.SecretTemplates.ExtendedMapping
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateExtendedMapping](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateExtendedMapping)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateExtendedMapping.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateExtendedMapping.ps1)
