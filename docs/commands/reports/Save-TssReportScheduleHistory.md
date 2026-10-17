---
title: Save-TssReportScheduleHistory
parent: Reports
grand_parent: Commands
---
# Save-TssReportScheduleHistory

## SYNOPSIS
Save the stored report file of a report schedule run

## SYNTAX

```
Save-TssReportScheduleHistory [-TssSession] <Session> -Id <Int32[]> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Download the report file stored for a report schedule run and save it to a folder.
The file name is the one Secret Server stores for the run; when none is returned the file is named report-schedule-history-\<HistoryId\>.
Returns the saved file.
Use Search-TssReportScheduleHistory to find the history IDs of a schedule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Save-TssReportScheduleHistory -TssSession $session -Id 112 -Output .\reports
```

Saves the report file of report schedule run 112 to the reports folder

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportScheduleHistory -TssSession $session -Id 7 | Save-TssReportScheduleHistory -TssSession $session -Output .\reports
```

Saves the report file of every stored run of report schedule 7

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
Report schedule history ID (ScheduleReportHistoryId of a run)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScheduleReportHistoryId, HistoryId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Output
Folder to save the file in

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Save-TssReportScheduleHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Save-TssReportScheduleHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Save-TssReportScheduleHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Save-TssReportScheduleHistory.ps1)
