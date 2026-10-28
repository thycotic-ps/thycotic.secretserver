---
title: Send-TssReportEmail
parent: Reports
grand_parent: Commands
---
# Send-TssReportEmail

## SYNOPSIS
Email a report

## SYNTAX

```
Send-TssReportEmail [-TssSession] <Session> -Id <Int32> -EmailAddress <String> [-Format <String>]
 [-Parameters <Hashtable>] [-DateOptionId <Int32>] [-TimeOptionId <Int32>] [-TimeZoneOptionId <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Run a report and email the result to an email address.
Secret Server sends the email through its configured SMTP server.
Returns True when Secret Server accepted the email.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Send-TssReportEmail -TssSession $session -Id 60 -EmailAddress 'audit@example.com' -Format Csv
```

Emails report 60 to audit@example.com in CSV format

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Send-TssReportEmail -TssSession $session -Id 3 -EmailAddress 'audit@example.com' -Parameters @{startdate = '2026-01-01'}
```

Emails report 3 in HTML format, with its start date parameter set

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

### -EmailAddress
Email address the report is sent to

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

### -Format
Format of the report in the email: Html or Csv, default Html

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Html
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameters
Report parameters provided as hash format of @{\<Parameter Name\> = \<Param Value\>}

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

### -DateOptionId
ID of the date format used for dates in the report

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

### -TimeOptionId
ID of the time format used for times in the report

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

### -TimeZoneOptionId
Time zone ID used for dates and times in the report

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Send-TssReportEmail](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Send-TssReportEmail)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Send-TssReportEmail.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Send-TssReportEmail.ps1)
