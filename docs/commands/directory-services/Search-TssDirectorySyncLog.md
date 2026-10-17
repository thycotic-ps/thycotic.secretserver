---
title: Search-TssDirectorySyncLog
parent: Directory Services
grand_parent: Commands
---
# Search-TssDirectorySyncLog

## SYNOPSIS
Search the Directory Services synchronization log

## SYNTAX

```
Search-TssDirectorySyncLog [-TssSession] <Session> [-EndDate <DateTime>] [-SearchText <String>]
 [-StartDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Search the directory synchronization log: when each entry was written, by which machine, and the message.
Without -StartDate the server returns the last five days.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectorySyncLog -TssSession $session -StartDate (Get-Date).AddDays(-1)
```

Show the synchronization log of the last day

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectorySyncLog -TssSession $session -SearchText error
```

Find synchronization log entries that mention error

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

### -EndDate
Latest entry date; the server default is now

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to match in the log message

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

### -StartDate
Earliest entry date; the server default is five days ago

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.DirectoryServices.SyncLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectorySyncLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectorySyncLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectorySyncLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectorySyncLog.ps1)
