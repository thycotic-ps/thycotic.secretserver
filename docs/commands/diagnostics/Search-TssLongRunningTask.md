---
title: Search-TssLongRunningTask
parent: Diagnostics
grand_parent: Commands
---
# Search-TssLongRunningTask

## SYNOPSIS
List the long-running tasks

## SYNTAX

```
Search-TssLongRunningTask [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Lists the long-running tasks shown on the Long Running Tasks tab under Admin, Diagnostics: background task locks Secret Server considers stale, with when each was created, its time to live in minutes and when it expires.
Release a stuck task with Clear-TssLongRunningTask.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssLongRunningTask -TssSession $session
```

List the long-running tasks

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

### Thycotic.PowerShell.Diagnostics.LongRunningTask[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (Secret Server Cloud answers Access denied).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssLongRunningTask](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssLongRunningTask)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssLongRunningTask.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssLongRunningTask.ps1)
