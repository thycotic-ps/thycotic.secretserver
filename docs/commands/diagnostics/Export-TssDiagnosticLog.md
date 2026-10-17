---
title: Export-TssDiagnosticLog
parent: Diagnostics
grand_parent: Commands
---
# Export-TssDiagnosticLog

## SYNOPSIS
Export the Secret Server logs to a zip file

## SYNTAX

```
Export-TssDiagnosticLog [-TssSession] <Session> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads the zip file of the Secret Server logs, the same as the Export Logs button under Admin, Diagnostics, and writes it to the Output folder as ThycoticSecretServerLogs_\<yyyyMMdd-HHmmss\>.zip.
Returns the file.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Export-TssDiagnosticLog -TssSession $session -Output C:\export
```

Download the logs zip file to C:\export

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

### -Output
Folder the zip file is written to

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Export-TssDiagnosticLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Export-TssDiagnosticLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Export-TssDiagnosticLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Export-TssDiagnosticLog.ps1)
