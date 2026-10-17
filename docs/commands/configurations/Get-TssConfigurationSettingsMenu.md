---
title: Get-TssConfigurationSettingsMenu
parent: Configurations
grand_parent: Commands
---
# Get-TssConfigurationSettingsMenu

## SYNOPSIS
Get the settings menu configuration

## SYNTAX

```
Get-TssConfigurationSettingsMenu [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the ids of the settings menu items that are not available on this instance (Hidden), and the Privilege Manager link when Privilege Manager is installed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssConfigurationSettingsMenu -TssSession $session).Hidden
```

List the settings menu items hidden on this instance

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

### Thycotic.PowerShell.Configuration.SettingsMenu
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSettingsMenu](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSettingsMenu)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSettingsMenu.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSettingsMenu.ps1)
