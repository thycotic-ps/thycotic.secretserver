---
title: Search-TssReportScheduleHistory
parent: Reports
grand_parent: Commands
---
# Search-TssReportScheduleHistory

## SYNOPSIS
Search the run history of a report schedule

## SYNTAX

### schedule (Default)
```
Search-TssReportScheduleHistory [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### history
```
Search-TssReportScheduleHistory [-TssSession] <Session> -HistoryId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Search the run history of a report schedule: one entry (ScheduleReportHistoryId and DateRun) per stored run.
With HistoryId it returns that stored run itself, including the report output as HTML when the run was stored as HTML.
Use Save-TssReportScheduleHistory to download the stored report file of a run.
Returns up to the session's Take value of entries per schedule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportScheduleHistory -TssSession $session -Id 7
```

Returns the stored runs of report schedule 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportScheduleHistory -TssSession $session -HistoryId 112
```

Returns stored run 112: when it ran, its format and its HTML output

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
Report schedule ID

```yaml
Type: Int32[]
Parameter Sets: schedule
Aliases: ScheduleReportId, ReportScheduleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HistoryId
Report schedule history ID (ScheduleReportHistoryId of a run)

```yaml
Type: Int32[]
Parameter Sets: history
Aliases: ScheduleReportHistoryId

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

### Thycotic.PowerShell.Reports.ScheduleHistorySummary[]
### Thycotic.PowerShell.Reports.ScheduleHistory
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportScheduleHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportScheduleHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportScheduleHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportScheduleHistory.ps1)
