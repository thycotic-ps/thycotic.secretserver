---
title: Search-TssPlatformMigration
parent: Platform Migration
grand_parent: Commands
---
# Search-TssPlatformMigration

## SYNOPSIS
Search the Delinea Platform migration runs

## SYNTAX

```
Search-TssPlatformMigration [-TssSession] <Session> [-EndDate <DateTime>] [-StartDate <DateTime>]
 [-Username <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Delinea Platform data migration runs, optionally filtered by the user who started them and by date.
Reads the migration history stored in Secret Server, so it also works on an instance without Delinea Platform integration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigration -TssSession $session
```

Returns every migration run

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigration -TssSession $session -StartDate (Get-Date).AddDays(-7)
```

Returns the migration runs of the last seven days

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
Return runs started up to this date.
Can be used without -StartDate

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

### -StartDate
Return runs started from this date.
Can be used without -EndDate

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

### -Username
Return runs started by users whose display name contains this text.
The server matches the display name, not the login name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformMigration.MigrationSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigration](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigration.ps1)
