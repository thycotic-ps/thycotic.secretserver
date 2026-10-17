---
title: Get-TssSecretTemplateLauncher
parent: Secret Templates
grand_parent: Commands
---
# Get-TssSecretTemplateLauncher

## SYNOPSIS
Get a launcher configured on a secret template

## SYNTAX

```
Get-TssSecretTemplateLauncher [-TssSession] <Session> -LauncherTypeId <Int32> -SecretTemplateId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the settings of one launcher type on a secret template: field mappings, input restrictions and connect-as settings.
Search-TssSecretTemplateLauncher lists the launchers of a template and the available launcher types.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
```

Get the settings of launcher type 2 on template 6007

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncher.ps1)
