---
title: Get-TssLauncherAgentAudit
parent: Launcher Agents
grand_parent: Commands
---
# Get-TssLauncherAgentAudit

## SYNOPSIS
Get launcher agent audits

## SYNTAX

### all (Default)
```
Get-TssLauncherAgentAudit [-TssSession] <Session> [<CommonParameters>]
```

### collection
```
Get-TssLauncherAgentAudit [-TssSession] <Session> -LauncherAgentCollectionId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the audit records of every launcher agent, or of the launcher agents in one launcher agent collection with -LauncherAgentCollectionId.
Secret Server keys this route by collection Id, not by agent Id.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgentAudit -TssSession $session
```

Get the audit records of every launcher agent

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgentAudit -TssSession $session -LauncherAgentCollectionId 3
```

Get the audit records of the launcher agents in launcher agent collection 3

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgent -TssSession $session -Id 23 | Get-TssLauncherAgentAudit -TssSession $session | Where-Object LauncherAgentId -eq 23
```

Get the audit records of launcher agent 23: the pipeline binds the agent's CollectionId, then the filter keeps that agent's rows

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

### -LauncherAgentCollectionId
Launcher agent collection Id.
Returns the audit records of the launcher agents in that collection.
Binds from the pipeline by LauncherAgentCollectionId, CollectionId (launcher agent output) or Id (launcher agent collection output).
Omit to get the audit records of every launcher agent

```yaml
Type: Int32[]
Parameter Sets: collection
Aliases: CollectionId, Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.LauncherAgents.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentAudit.ps1)
