---
external help file: Thycotic.SecretServer.dll-Help.xml
Module Name: Thycotic.SecretServer
schema: 2.0.0
---

# Start-TssLog

## SYNOPSIS
Creates an initial log file with a header.

## SYNTAX

```
Start-TssLog [[-LogFilePath] <String>] [[-LogFormat] <String>] [[-ScriptVersion] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a log file (will delete if the name already exists) and adds a formatted header.

## EXAMPLES

### Example 1
```powershell
$newLog = New-TemporaryFile
Start-TssLog -LogFilePath $newLog.FullName -ScriptVersion '1.0.4'
```

Generate a new temporary file to use as a log, writing Script version of 1.0.4.

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

### -ScriptVersion
Script Version to include as reference in the log file header

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Start-TssLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Start-TssLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/StartLogCmdlet.cs](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/StartLogCmdlet.cs)
