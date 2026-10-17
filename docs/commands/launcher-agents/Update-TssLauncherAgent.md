---
title: Update-TssLauncherAgent
parent: Launcher Agents
grand_parent: Commands
---
# Update-TssLauncherAgent

## SYNOPSIS
Update a launcher agent

## SYNTAX

### override (Default)
```
Update-TssLauncherAgent [-TssSession] <Session> -Id <Int32> [-Active] [-RecordKeystrokes]
 [-RecordStandaloneSessions] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### inherit
```
Update-TssLauncherAgent [-TssSession] <Session> -Id <Int32> [-Active] [-InheritRecordingSettings]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the active flag and recording overrides of a launcher agent.
The endpoint replaces the whole agent, so the current agent is read first (Get-TssLauncherAgent -IncludeInactive) and every parameter you omit keeps its current value.
-InheritRecordingSettings clears both recording overrides so the agent follows its collection.
Secret Server rejects updates to an agent whose collection is inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssLauncherAgent -TssSession $session -Id 3 -Active:$false
```

Deactivate launcher agent 3 and keep its recording settings

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssLauncherAgent -TssSession $session -Id 3 -RecordKeystrokes:$false
```

Stop keystroke recording on agent 3 regardless of its collection

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssLauncherAgent -TssSession $session -Id 3 -InheritRecordingSettings
```

Make agent 3 follow the recording settings of its collection again

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

### -Id
Launcher agent Id

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

### -Active
Set the agent active (-Active) or inactive (-Active:$false)

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

### -RecordKeystrokes
Override the collection: record keystroke data on this agent (-RecordKeystrokes) or not (-RecordKeystrokes:$false)

```yaml
Type: SwitchParameter
Parameter Sets: override
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordStandaloneSessions
Override the collection: record standalone (headless) sessions on this agent (-RecordStandaloneSessions) or not (-RecordStandaloneSessions:$false)

```yaml
Type: SwitchParameter
Parameter Sets: override
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritRecordingSettings
Clear both recording overrides so the agent uses the recording settings of its collection

```yaml
Type: SwitchParameter
Parameter Sets: inherit
Aliases:

Required: True
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

### Thycotic.PowerShell.LauncherAgents.LauncherAgent
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgent](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgent)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgent.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgent.ps1)
