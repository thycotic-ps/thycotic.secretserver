---
title: Search-TssLauncherAgent
parent: Launcher Agents
grand_parent: Commands
---
# Search-TssLauncherAgent

## SYNOPSIS
Search launcher agents

## SYNTAX

```
Search-TssLauncherAgent [-TssSession] <Session> [-IncludeInactive] [-LauncherAgentCollectionId <Int32>]
 [-OutOfDate] [-SearchText <String>] [<CommonParameters>]
```

## DESCRIPTION
Search Advanced Session Recording launcher agents.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLauncherAgent -TssSession $session -OutOfDate
```

Get the agents older than the minimum recommended version

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

### -IncludeInactive
Include inactive agents

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

### -LauncherAgentCollectionId
Return only agents in this launcher agent collection

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutOfDate
Return only out-of-date agents.
Without it, or with -OutOfDate:$false, agents of every version are returned

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

### -SearchText
Text to match against the agent host name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.LauncherAgents.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgent](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgent)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgent.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgent.ps1)
