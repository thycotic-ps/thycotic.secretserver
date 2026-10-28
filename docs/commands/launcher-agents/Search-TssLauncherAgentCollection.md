---
title: Search-TssLauncherAgentCollection
parent: Launcher Agents
grand_parent: Commands
---
# Search-TssLauncherAgentCollection

## SYNOPSIS
Search launcher agent collections

## SYNTAX

```
Search-TssLauncherAgentCollection [-TssSession] <Session> [-IncludeInactive] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search Advanced Session Recording launcher agent collections.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLauncherAgentCollection -TssSession $session -IncludeInactive
```

Get every launcher agent collection, active and inactive

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
Include inactive collections

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
Text to match against the collection name

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

### Thycotic.PowerShell.LauncherAgents.CollectionSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgentCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Search-TssLauncherAgentCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgentCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Search-TssLauncherAgentCollection.ps1)
