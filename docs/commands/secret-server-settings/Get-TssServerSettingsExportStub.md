---
title: Get-TssServerSettingsExportStub
parent: Secret Server Settings
grand_parent: Commands
---
# Get-TssServerSettingsExportStub

## SYNOPSIS
Get an empty Secret Server settings template

## SYNTAX

```
Get-TssServerSettingsExportStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the settings export shape with every section empty. Nothing is read from the server: the instance ID is all zeros and the configuration version is blank. Use Export-TssServerSettings for the real values.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerSettingsExportStub -TssSession $session
```

Returns the empty settings template

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

### Thycotic.PowerShell.SecretServerSettings.Settings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsExportStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsExportStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsExportStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsExportStub.ps1)
