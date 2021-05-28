---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version:
schema: 2.0.0
title: Write-TssLog
---

# Write-TssLog

## SYNOPSIS
Writes a message to specified log file

## SYNTAX

```
Write-TssLog [[-LogFormat] <String>] [[-LogFilePath] <String>] [[-MessageType] <String>] [[-Message] <String>]
 [-Divider] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -LogFormat
Format of log to generate, default to LOG; allowed: log, csv, json, xml, cmtrace

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Log
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFilePath
Exact log path and filename to use

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

### -MessageType
Message type, default INFO; allowed: INFO, WARNING, ERROR, FATAL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: INFO
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Message content to write to file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Divider
Character divider will be added to file as INFO message, using plus sign (+)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
