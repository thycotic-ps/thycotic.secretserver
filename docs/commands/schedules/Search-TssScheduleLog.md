---
title: Search-TssScheduleLog
parent: Schedules
grand_parent: Commands
---
# Search-TssScheduleLog

## SYNOPSIS
Search the recurring schedule log

## SYNTAX

```
Search-TssScheduleLog [-TssSession] <Session> [-EndDate <DateTime>] [-SearchText <String>]
 [-StartDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Returns recurring schedule log entries, optionally filtered by text and by date range.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssScheduleLog -TssSession $session -StartDate (Get-Date).AddDays(-1)
```

Returns the recurring schedule log entries of the last day

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

### -EndDate
Return entries logged on or before this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to search the log messages for

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

### -StartDate
Return entries logged on or after this date

```yaml
Type: DateTime
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

### Thycotic.PowerShell.Schedules.ScheduleLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Search-TssScheduleLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Search-TssScheduleLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Search-TssScheduleLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Search-TssScheduleLog.ps1)
