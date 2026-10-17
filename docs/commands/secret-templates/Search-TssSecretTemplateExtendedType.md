---
title: Search-TssSecretTemplateExtendedType
parent: Secret Templates
grand_parent: Commands
---
# Search-TssSecretTemplateExtendedType

## SYNOPSIS
Search extended types

## SYNTAX

```
Search-TssSecretTemplateExtendedType [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the extended types that can be mapped onto a secret template, such as SSH key and certificate types.
Use the ExtendedTypeId with the *-TssSecretTemplateExtendedMapping cmdlets.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplateExtendedType -TssSession $session
```

Returns every extended type

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.ExtendedType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateExtendedType](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateExtendedType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateExtendedType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateExtendedType.ps1)
