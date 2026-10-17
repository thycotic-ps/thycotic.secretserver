---
title: New-TssLauncherAgentCollection
parent: Launcher Agents
grand_parent: Commands
---
# New-TssLauncherAgentCollection

## SYNOPSIS
Create a launcher agent collection

## SYNTAX

```
New-TssLauncherAgentCollection [-TssSession] <Session> -Name <String> [-RecordKeystrokes]
 [-RecordStandaloneSessions] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create an Advanced Session Recording launcher agent collection.
The recording switches are always sent; an omitted switch is false.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssLauncherAgentCollection -TssSession $session -Name 'Jump hosts' -RecordKeystrokes
```

Create a collection that records keystrokes but not standalone sessions

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

### -Name
Collection name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordKeystrokes
Agents in the collection record keystroke data

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

### -RecordStandaloneSessions
Agents in the collection record standalone (headless) sessions

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

### Thycotic.PowerShell.LauncherAgents.Collection
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/New-TssLauncherAgentCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/New-TssLauncherAgentCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/New-TssLauncherAgentCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/New-TssLauncherAgentCollection.ps1)
