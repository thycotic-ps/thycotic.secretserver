---
title: Get-TssSecretTemplateLauncherStub
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplateLauncherStub

## SYNOPSIS
Get the default launcher settings for a launcher type on a secret template

## SYNTAX

```
Get-TssSecretTemplateLauncherStub [-TssSession] <Session> -LauncherTypeId <Int32> -SecretTemplateId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns unsaved launcher settings that map a launcher type onto a secret template, with the field mappings Secret Server suggests.
Nothing is created.
Launcher fields the stub cannot map have SecretFieldId 0; set them to a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue), then pass the result to New-TssSecretTemplateLauncher.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$stub = Get-TssSecretTemplateLauncherStub -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
$stub.Fields
```

Show the field mappings Secret Server suggests for launcher type 2 on template 6007

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

### -LauncherTypeId
Launcher type ID, as returned by Search-TssSecretTemplateLauncher -LauncherType

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
Aliases:

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

### Thycotic.PowerShell.SecretTemplates.Launcher
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncherStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncherStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncherStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncherStub.ps1)
