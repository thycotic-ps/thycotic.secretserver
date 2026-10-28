---
title: Search-TssReportAudit
parent: Reports
grand_parent: Commands
---
# Search-TssReportAudit

## SYNOPSIS
Search report audit entries

## SYNTAX

### all (Default)
```
Search-TssReportAudit [-TssSession] <Session> [<CommonParameters>]
```

### report
```
Search-TssReportAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Search the audit trail of reports: views, edits, exports and other report actions.
Without Id it returns audit entries for all reports; with Id it returns the entries of those reports.
Returns up to the session's Take value of entries per call.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportAudit -TssSession $session
```

Returns audit entries for all reports

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportAudit -TssSession $session -Id 60 | Select-Object DateRecorded, Action, DisplayName
```

Returns when, what and who for each entry in the audit trail of report 60

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
Report ID; returns only the audit entries of these reports

```yaml
Type: Int32[]
Parameter Sets: report
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

### Thycotic.PowerShell.Reports.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportAudit.ps1)
