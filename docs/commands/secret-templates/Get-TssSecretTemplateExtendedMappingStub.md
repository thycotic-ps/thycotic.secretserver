---
title: Get-TssSecretTemplateExtendedMappingStub
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplateExtendedMappingStub

## SYNOPSIS
Get a stub for a new extended mapping of a secret template

## SYNTAX

```
Get-TssSecretTemplateExtendedMappingStub [-TssSession] <Session> -ExtendedTypeId <Int32>
 -SecretTemplateId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Returns the extended fields of an extended type with the template fields the server would map them to, as a starting point for New-TssSecretTemplateExtendedMapping.
Nothing is created.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateExtendedMappingStub -TssSession $session -SecretTemplateId 6 -ExtendedTypeId 1
```

Returns the stub for mapping extended type 1 onto secret template 6

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.ExtendedMapping
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateExtendedMappingStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateExtendedMappingStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateExtendedMappingStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateExtendedMappingStub.ps1)
