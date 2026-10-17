---
title: Get-TssLauncherAgentConfigurationState
parent: Launcher Agents
grand_parent: Commands
---
# Get-TssLauncherAgentConfigurationState

## SYNOPSIS
Get the launcher agent configuration state

## SYNTAX

```
Get-TssLauncherAgentConfigurationState [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the launcher agent configuration state, which holds the minimum recommended agent version.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssLauncherAgentConfigurationState -TssSession $session).MinimumRecommendedVersion
```

Get the minimum recommended launcher agent version

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

### Thycotic.PowerShell.LauncherAgents.ConfigurationState
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentConfigurationState](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentConfigurationState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentConfigurationState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentConfigurationState.ps1)
