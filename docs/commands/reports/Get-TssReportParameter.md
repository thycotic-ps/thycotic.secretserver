# Get-TssReportParameter

## SYNOPSIS
Get default report parameters.

## SYNTAX

```
Get-TssReportParameter [-TssSession] <Session> -Id <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get default report parameters.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportParameter -TssSession $session -Id 34
```

Get report parameters for Report 34.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Reports.Parameter
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportParameter](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportParameter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportParameter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportParameter.ps1)

