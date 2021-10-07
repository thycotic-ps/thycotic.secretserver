# Get-TssDiagnosticConnectivityReport

## SYNOPSIS
Get Connectivity Report

## SYNTAX

```
Get-TssDiagnosticConnectivityReport [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get Connectivity Report, built-in test to check for Internet connectivity (google.com, yahoo.com and updates.thycotic.net)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiagnosticConnectivityReport -TssSession $session
```

Return test results for Internet connection from Secret Server web node

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

### Thycotic.PowerShell.Diagnostics.ConnectivityReport
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticConnectivityReport](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticConnectivityReport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticConnectivityReport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticConnectivityReport.ps1)

