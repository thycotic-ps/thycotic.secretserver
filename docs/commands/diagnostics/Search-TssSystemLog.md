# Search-TssSystemLog

## SYNOPSIS
Search the Secret Server System Log

## SYNTAX

```
Search-TssSystemLog [-TssSession] <Session> [-SearchText <String>] [-LogLevel <LogLevel>] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the Secret Server System Log

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSystemLog -TssSession $session -SearchText "powershell"
```

Return Log messages matching the text "powershell"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSystemLog -TssSession $session -SearchText "Azure AD"
```

Return Log messages matching the text "Azure AD"

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

### -SearchText
Text to search for in System Log

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

### -LogLevel
Log Level to filter on

```yaml
Type: LogLevel
Parameter Sets: (All)
Aliases:
Accepted values: Emergency, Alert, Critical, Error, Warning, Notice, Information, Debug

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default DateRecorded

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: DateRecorded
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Diagnostics.SystemLog
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssSystemLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssSystemLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssSystemLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssSystemLog.ps1)

