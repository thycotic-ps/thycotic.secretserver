---
title: Search-TssLauncherAgentIssue
parent: Launcher Agents
grand_parent: Commands
---
# Search-TssLauncherAgentIssue

## SYNOPSIS
Search launcher agents that have issues

## SYNTAX

```
Search-TssLauncherAgentIssue [-TssSession] <Session> [-LauncherAgentCollectionId <Int32>]
 [-SearchText <String>] [<CommonParameters>]
```

## DESCRIPTION
Search Advanced Session Recording launcher agents that report an issue.
The Issue property says what is wrong.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLauncherAgentIssue -TssSession $session | Select-Object HostName, Issue
```

List the agents with issues and what each issue is

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgentIssue](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgentIssue)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgentIssue.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgentIssue.ps1)
