---
title: Get-TssSecretTemplateFieldStub
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplateFieldStub

## SYNOPSIS
Get a new secret template field with default values

## SYNTAX

```
Get-TssSecretTemplateFieldStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns an unsaved secret template field filled with the Secret Server defaults.
Nothing is created.
Use it to see the default field settings before adding a field with Add-TssSecretTemplateField.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateFieldStub -TssSession $session
```

Get the default settings of a new secret template field

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

### Thycotic.PowerShell.SecretTemplates.FieldDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateFieldStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateFieldStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateFieldStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateFieldStub.ps1)
