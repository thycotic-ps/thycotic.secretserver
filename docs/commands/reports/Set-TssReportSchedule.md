---
title: Set-TssReportSchedule
parent: Reports
grand_parent: Commands
---
# Set-TssReportSchedule

## SYNOPSIS
Set the properties of a report schedule

## SYNTAX

```
Set-TssReportSchedule [-TssSession] <Session> -Id <Int32> [-Format <String>] [-UserParameterValue <Int32>]
 [-GroupParameterValue <Int32>] [-FolderParameterValue <Int32>] [-FolderPathParameterValue <String>]
 [-CustomParameterValue <String>] [-StartDateParameterValue <String>]
 [-StartDateParameterSpecificDateValue <DateTime>] [-EndDateParameterValue <String>]
 [-EndDateParameterSpecificDateValue <DateTime>] [-Schedule <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the format, report parameter values or schedule of a report schedule.
Only the parameters provided are changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportSchedule -TssSession $session -Id 7 -Format Csv
```

Stores and emails the runs of report schedule 7 as CSV

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportSchedule -TssSession $session -Id 7 -StartDateParameterValue StartPreviousMonth -EndDateParameterValue EndPreviousMonth -Schedule @{historySize = 12; sendEmail = $true}
```

Runs report schedule 7 over the previous month, keeps 12 runs and emails each run

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
Type: Int32
Parameter Sets: (All)
Aliases: ScheduleReportId, ReportScheduleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Format
Format of the stored and emailed report: Html or Csv

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

### -UserParameterValue
User ID for the report's user parameter

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

### -GroupParameterValue
Group ID for the report's group parameter

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

### -FolderParameterValue
Folder ID for the report's folder parameter

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

### -FolderPathParameterValue
Folder path for the report's folder path parameter

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

### -CustomParameterValue
Value for the report's custom text parameter

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

### -StartDateParameterValue
Start date option for the report's start date parameter; SpecificDate uses StartDateParameterSpecificDateValue

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

### -StartDateParameterSpecificDateValue
Start date used when StartDateParameterValue is SpecificDate

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

### -EndDateParameterValue
End date option for the report's end date parameter; SpecificDate uses EndDateParameterSpecificDateValue

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

### -EndDateParameterSpecificDateValue
End date used when EndDateParameterValue is SpecificDate

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

### -Schedule
Schedule properties to change, provided as hash format of @{\<property\> = \<value\>}.
Keys are the schedule properties of the REST API: scheduleName, changeType, days, weeks, startingOn, historySize, sendEmail, sendEmailWithHighPriority, additionalEmailAddresses, emailGroups, healthCheck, monday through sunday, monthlyScheduleType, monthlyDay, monthlyDayOfMonth, monthlyDayOrder, monthlyDayOrderRecurrence, monthlyDayRecurrence.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.Reports.ReportSchedule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportSchedule.ps1)
