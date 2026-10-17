---
title: Get-TssSessionMonitoringConfiguration
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSessionMonitoringConfiguration

## SYNOPSIS
Get the Session Monitoring configuration

## SYNTAX

```
Get-TssSessionMonitoringConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Session Monitoring page configuration: the default number of days the session search is bounded to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionMonitoringConfiguration -TssSession $session
```

Get the Session Monitoring configuration

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

### Thycotic.PowerShell.RecordedSessions.SessionMonitoringConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionMonitoringConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionMonitoringConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionMonitoringConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionMonitoringConfiguration.ps1)
