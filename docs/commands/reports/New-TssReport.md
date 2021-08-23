# New-TssReport

## SYNOPSIS
Short of what command does

## SYNTAX

```
New-TssReport [-TssSession] <Session> [-ReportName] <String> [-CategoryId] <Int32> -Description <String>
 [-ChartType <String>] [-Is3DReport] [-PageSize <Int32>] [-Paging <String>] -ReportSql <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Longer of what command does

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssReport -TssSession $session -ReportName 'TssTestReport' -CategoryId 15 -ReportSql "SELECT 1" -Description 'Tss Test Report for POC'
```

Creates a new report with minimum requirements Name, CategoryId, ReportSql and Description

### EXAMPLE 2
```
$session = New-TssSession -SecretServer 'https://alpha/SecretServer' -Credential $ssCred
$params = @{
    ReportName = 'Tss Test Report from SQL File'
    Category = (Get-TssReportCategory -TssSession $session -All | Where-Object Name -eq 'TssCategory').CategoryId
    Description = 'Test report using SQL file'
    ReportSql = (Get-Content .\tests\exports\testReport.sql | Out-String)
}
New-TssReport -TssSession $session @params
```

Create a new report where the T-SQL is stored in a SQL script file

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

### -ReportName
Name of the report

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CategoryId
Category for the report

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Description
Description of the report

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ChartType
Chart type for the report

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

### -Is3DReport
Report chart should be 3D

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

### -PageSize
Number of records the report should return per page

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

### -Paging
Perform paging in the database (default) or application server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Database
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReportSql
T-SQL for the report to run

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReport.ps1)

