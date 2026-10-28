---
title: Search-TssReportChartType
parent: Reports
grand_parent: Commands
---
# Search-TssReportChartType

## SYNOPSIS
List the chart types available for reports

## SYNTAX

```
Search-TssReportChartType [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
List the chart types (Id and Name) a report can use for its ChartType.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportChartType -TssSession $session
```

Returns every report chart type with its Id and Name

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

### Thycotic.PowerShell.Reports.ChartType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportChartType](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportChartType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportChartType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportChartType.ps1)
