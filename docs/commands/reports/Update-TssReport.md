---
title: Update-TssReport
parent: Reports
grand_parent: Commands
---
# Update-TssReport

## SYNOPSIS
Update a report

## SYNTAX

```
Update-TssReport [-TssSession] <Session> -Id <Int32> -Name <String> -Description <String> -CategoryId <Int32>
 -ReportSql <String> [-ChartType <String>] [-Is3DReport] [-PageSize <Int32>] [-UseDatabasePaging]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a report by replacing its definition: name, description, category, SQL, chart and paging.
Every property is sent, so a property not provided is reset.
Pipe the report from Get-TssReport to keep its current values and change only the parameters provided.
Reports that require dual control approval to edit cannot be updated with this command.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReport -TssSession $session -Id 112 | Update-TssReport -TssSession $session -Description 'Secrets changed in the last 30 days'
```

Changes the description of report 112, keeping every other property

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssReport -TssSession $session -Id 112 -Name 'Folder count' -Description 'Number of folders' -CategoryId 3 -ReportSql 'SELECT COUNT(*) AS [Folders] FROM tbFolder' -PageSize 50
```

Replaces the definition of report 112

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
Type: Int32
Parameter Sets: (All)
Aliases: ReportId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Name of the report

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReportName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
Description of the report, required by Secret Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CategoryId
Report category ID the report belongs to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReportSql
SQL query that defines the report

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ChartType
Chart type of the report (see Search-TssReportChartType); empty for no chart

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Is3DReport
Show the report chart in 3D

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PageSize
Number of records per page, default 15

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 15
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseDatabasePaging
Page the report in SQL Server instead of the application server

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Thycotic.PowerShell.Reports.Report
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Update-TssReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Update-TssReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Update-TssReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Update-TssReport.ps1)
