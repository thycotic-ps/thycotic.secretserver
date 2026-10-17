---
title: Set-TssProtocolHandlerSettings
parent: Configurations
grand_parent: Commands
---
# Set-TssProtocolHandlerSettings

## SYNOPSIS
Update the Protocol Handler install-time settings

## SYNTAX

```
Set-TssProtocolHandlerSettings [-TssSession] <Session> [-ProtocolHandlerInstallTimeAllowedDomains <String>]
 [-ProtocolHandlerInstallTimeDisableAutoUpdate] [-ProtocolHandlerInstallTimeSettingsEnabled]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the settings Secret Server injects into the Protocol Handler installer: whether install-time settings are on, whether auto update is turned off, and the domains or IP addresses the Protocol Handler may connect to.
Only the parameters you pass are changed.
Returns the settings after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProtocolHandlerSettings -TssSession $session -ProtocolHandlerInstallTimeSettingsEnabled -ProtocolHandlerInstallTimeAllowedDomains 'ss.example.com'
```

Turn on install-time settings and restrict the Protocol Handler to one Secret Server host

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

### -ProtocolHandlerInstallTimeAllowedDomains
Comma-separated domains or IP addresses the Protocol Handler may connect to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProtocolHandlerInstallTimeDisableAutoUpdate
Turn off Protocol Handler auto update at install time

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProtocolHandlerInstallTimeSettingsEnabled
Inject the install-time settings into the Protocol Handler installer

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Thycotic.PowerShell.Configuration.ProtocolHandlerSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssProtocolHandlerSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssProtocolHandlerSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssProtocolHandlerSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssProtocolHandlerSettings.ps1)
