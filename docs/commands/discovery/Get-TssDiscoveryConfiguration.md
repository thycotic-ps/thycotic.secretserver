---
title: Get-TssDiscoveryConfiguration
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryConfiguration

## SYNOPSIS
Get the Discovery configuration

## SYNTAX

```
Get-TssDiscoveryConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns whether Discovery is enabled, how often it runs, the AD batch size for engines and how long Discovery logs are kept.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryConfiguration -TssSession $session
```

Get the Discovery configuration

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

### Thycotic.PowerShell.Discovery.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryConfiguration.ps1)
