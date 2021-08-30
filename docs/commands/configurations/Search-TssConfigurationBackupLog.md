# Search-TssConfigurationBackupLog

## SYNOPSIS
Search logs for the Database Backup runs

## SYNTAX

```
Search-TssConfigurationBackupLog [-TssSession] <Session> [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search logs for the Database Backup runs

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssConfigurationBackupLog -TssSession $session
```

Returns the logs for the Database Backup processing

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

### -SortBy
Sort by specific property, default BackupTime

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: BackupTime
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.DbBackupLog
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationBackupLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationBackupLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationBackupLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationBackupLog.ps1)

