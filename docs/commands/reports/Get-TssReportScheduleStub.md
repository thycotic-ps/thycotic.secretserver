---
title: Get-TssReportScheduleStub
parent: Reports
grand_parent: Commands
---
# Get-TssReportScheduleStub

## SYNOPSIS
Get a default report schedule for a report

## SYNTAX

```
Get-TssReportScheduleStub [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get a report schedule stub for a report: the default values Secret Server fills in for a new schedule of that report.
Nothing is created; use New-TssReportSchedule to create the schedule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportScheduleStub -TssSession $session -Id 60
```

Returns the default schedule values for a new schedule of report 60

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
Report ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ReportId

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

### Thycotic.PowerShell.Reports.ReportSchedule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportScheduleStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportScheduleStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportScheduleStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportScheduleStub.ps1)
