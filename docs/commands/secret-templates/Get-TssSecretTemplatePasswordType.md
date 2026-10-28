---
title: Get-TssSecretTemplatePasswordType
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplatePasswordType

## SYNOPSIS
Get the password changing settings of a secret template

## SYNTAX

```
Get-TssSecretTemplatePasswordType [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the password type (password changer) of a secret template, its remote password changing and heartbeat settings, and the mapping of template fields to password type fields.
PasswordTypeId is empty when no password type is assigned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplatePasswordType -TssSession $session -Id 6007
```

Get the password changing settings of template 6007

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
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretTemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.PasswordType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplatePasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplatePasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplatePasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplatePasswordType.ps1)
