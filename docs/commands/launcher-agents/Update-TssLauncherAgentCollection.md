---
title: Update-TssLauncherAgentCollection
parent: Launcher Agents
grand_parent: Commands
---
# Update-TssLauncherAgentCollection

## SYNOPSIS
Update a launcher agent collection

## SYNTAX

```
Update-TssLauncherAgentCollection [-TssSession] <Session> -Id <Int32> [-Active] [-Name <String>]
 [-RecordKeystrokes] [-RecordStandaloneSessions] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update the name, active flag and recording defaults of a launcher agent collection.
The endpoint replaces the whole collection, so the current collection is read first (Get-TssLauncherAgentCollection -IncludeInactive) and every parameter you omit keeps its current value.
Secret Server rejects any update to an inactive collection, so -Active:$false cannot be undone through the API.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssLauncherAgentCollection -TssSession $session -Id 1 -Name 'Jump hosts (EU)'
```

Rename launcher agent collection 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssLauncherAgentCollection -TssSession $session -Id 1 -Active:$false
```

Deactivate launcher agent collection 1

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
Launcher agent collection Id

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
Set the collection active (-Active) or inactive (-Active:$false)

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

### -Name
New collection name

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

### -RecordKeystrokes
Agents in the collection record keystroke data (-RecordKeystrokes) or not (-RecordKeystrokes:$false)

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
Agents in the collection record standalone (headless) sessions (-RecordStandaloneSessions) or not (-RecordStandaloneSessions:$false)

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgentCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgentCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgentCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgentCollection.ps1)
