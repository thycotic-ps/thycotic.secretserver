---
title: Search-TssDashboardReport
parent: Dashboard Services
grand_parent: Commands
---
# Search-TssDashboardReport

## SYNOPSIS
List the reports available to the dashboard

## SYNTAX

```
Search-TssDashboardReport [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the active reports the current user can add to the dashboard, with the report id, name, category and whether the report has a chart.
The list is not paged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardReport -TssSession $session
```

List the active reports available to the dashboard

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardReport -TssSession $session | Where-Object HasChart
```

List the dashboard reports that have a chart

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

### Thycotic.PowerShell.DashboardServices.DashboardReport[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardReport.ps1)
