# Get-TssDiagnosticBackgroundProcess

## SYNOPSIS
Get background process information

## SYNTAX

```
Get-TssDiagnosticBackgroundProcess [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get background process information

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiagnosticBackgroundProcess -TssSession $session
```

Return background process information

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

### Thycotic.PowerShell.Diagnostics.BackgroundProcess
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticBackgroundProcess](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticBackgroundProcess)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticBackgroundProcess.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticBackgroundProcess.ps1)

