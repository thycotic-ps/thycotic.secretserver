---
title: Get-TssMobileConfiguration
parent: Mobile Configuration
grand_parent: Commands
---
# Get-TssMobileConfiguration

## SYNOPSIS
Get the mobile configuration

## SYNTAX

```
Get-TssMobileConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the mobile app settings: how many minutes the mobile app may work offline before it must reconnect.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMobileConfiguration -TssSession $session
```

Show the mobile app offline limit

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

### Thycotic.PowerShell.MobileConfiguration.Settings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/mobile-configuration/Get-TssMobileConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/mobile-configuration/Get-TssMobileConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mobile-configuration/Get-TssMobileConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mobile-configuration/Get-TssMobileConfiguration.ps1)
