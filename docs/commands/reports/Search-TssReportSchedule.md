# Search-TssReportSchedule

## SYNOPSIS
Search report schedule

## SYNTAX

```
Search-TssReportSchedule [-TssSession] <Session> [-IncludeDeleted] [-ReportId <Int32>] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search for report schedule(s)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportSchedule -TssSession $session -ReportId 50
```

Return all schedules found associated with Report ID 50.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportSchedule -TssSession $session -IncludeDeleted
```

Returns list of all report schedules, including those that were deleted

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

### -IncludeDeleted
Include deleted reports

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

### -ReportId
Report ID

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

### -SortBy
Sort by specific property, default Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Name
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Reports.ScheduleSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Serach-TssReportSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Serach-TssReportSchedule.ps1)

