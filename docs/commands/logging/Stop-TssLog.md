---
external help file: Thycotic.SecretServer.dll-Help.xml
Module Name: Thycotic.SecretServer
schema: 2.0.0
---

# Stop-TssLog

## SYNOPSIS
Adds footer to the end of the log file.

## SYNTAX

```
Stop-TssLog [[-LogFilePath] <String>] [[-LogFormat] <String>] [<CommonParameters>]
```

## DESCRIPTION
Appends a footer to the log file to "close" the logging process. This should be called at the end of your script or workflow.

## EXAMPLES

### Example 1
```powershell
Stop-TssLog -LogFilePath $newLog.FullName
```

Log file from the Start-TssLog call passed in and footer written to the file.

## PARAMETERS

### -LogFilePath
Full file path to the log file to create

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFormat
Format of log to generate, default to LOG; allowed: log, csv

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: log, csv

Required: False
Position: 1
Default value: Log
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Stop-TssLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Stop-TssLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/StopLogCmdlet.cs](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/StopLogCmdlet.cs)