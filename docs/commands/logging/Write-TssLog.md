---
external help file: Thycotic.SecretServer.dll-Help.xml
Module Name: Thycotic.SecretServer
schema: 2.0.0
---

# Write-TssLog

## SYNOPSIS
Writes message to the log file.

## SYNTAX

### message
```
Write-TssLog [-LogFilePath] <String> [[-LogFormat] <String>] [[-MessageType] <String>] [[-Message] <String>]
 [<CommonParameters>]
```

### divider
```
Write-TssLog [-LogFilePath] <String> [[-LogFormat] <String>] [[-MessageType] <String>] [-Divider]
 [[-DividerCharacter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Writes the message provided by appending. This is used during your script process or workflow to add messages based on the MessageType desired (error, warning, info, etc.).

## EXAMPLES

### Example 1
```powershell
Write-TssLog -LogFilePath $newLog.FullName -LogFormat 'log' -MessageType ERROR -Message "Issue capturing secret details: $($_.Exception)"
```

Appends an informational message including an error's exception (added to the catch block of a call to a function) using LOG format.

### Example 2
```powershell
Write-TssLog -LogFilePath $newLog.FullName -LogFormat 'csv' -MessageType ERROR -Message "Issue capturing secret details: $($_.Exception)"
```

Appends an informational message including an error's exception (added to the catch block of a call to a function) using CSV format.

## PARAMETERS

### -Divider
Switch to indicate a divider is appended to the log file.

```yaml
Type: SwitchParameter
Parameter Sets: divider
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DividerCharacter
The character to use for the divider, autogenerates 120-character divider and append to the log file. Defaults to plus-sign (+)

```yaml
Type: String
Parameter Sets: divider
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFilePath
Full file path to the log file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### -Message
Message to append to the log

```yaml
Type: String
Parameter Sets: message
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MessageType
Message type to write to the log, default INFO (allowed INFO, WARNING, ERROR, FATAL)

```yaml
Type: String
Parameter Sets: message
Aliases:
Accepted values: INFO, WARNING, ERROR, FATAL

Required: False
Position: 2
Default value: INFO
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: divider
Aliases:
Accepted values: INFO, WARNING, ERROR, FATAL

Required: False
Position: 2
Default value: INFO
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Write-TssLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/logging/Write-TssLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/WriteLogCmdlet.cs](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/Thycotic.SecretServer/cmdlets/logging/WriteLogCmdlet.cs)
