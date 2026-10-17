---
title: Clear-TssLongRunningTask
parent: Diagnostics
grand_parent: Commands
---
# Clear-TssLongRunningTask

## SYNOPSIS
Clear a long-running task

## SYNTAX

```
Clear-TssLongRunningTask [-TssSession] <Session> -TaskName <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears a long-running task: releases the lock a background task holds so the task can run again, the same as clearing it on the Long Running Tasks tab under Admin, Diagnostics.
Clear only a task that is stuck.
Returns an object whose Success property is True when the task was cleared.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLongRunningTask -TssSession $session
```

List the long-running tasks

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLongRunningTask -TssSession $session | Where-Object TaskName -Like '*Heartbeat*' | Clear-TssLongRunningTask -TssSession $session
```

Clear the long-running heartbeat tasks

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

### -TaskName
Name of the long-running task, as returned by Search-TssLongRunningTask

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Diagnostics.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (Secret Server Cloud answers Access denied).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssLongRunningTask](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssLongRunningTask)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssLongRunningTask.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssLongRunningTask.ps1)
