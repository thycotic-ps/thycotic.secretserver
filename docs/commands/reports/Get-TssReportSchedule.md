# Get-TssReportSchedule

## SYNOPSIS
Get a Report Schedule

## SYNTAX

```
Get-TssReportSchedule [-TssSession] <Session> -ScheduleId <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a Report Schedule

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportSchedule -TssSession $session -Id 35
```

Get Report Schedule ID 35

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

### -ScheduleId
Report Schedule ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScheduleReportId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportSchedule.ps1)

