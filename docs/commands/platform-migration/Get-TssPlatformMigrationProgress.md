---
title: Get-TssPlatformMigrationProgress
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformMigrationProgress

## SYNOPSIS
Get the progress of a Delinea Platform migration run

## SYNTAX

```
Get-TssPlatformMigrationProgress [-TssSession] <Session> [-Id <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns how far a Delinea Platform data migration run has got: status, processed and total item counts, and whether it is still running.
Without -Id the server reports the current or most recent run.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformMigrationProgress -TssSession $session
```

Returns the progress of the current or most recent migration run

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformMigrationProgress -TssSession $session -Id 3
```

Returns the progress of migration run 3

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

### -Id
Migration run ID.
Omit for the current or most recent run

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: MigrationId

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformMigration.Progress
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationProgress](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationProgress)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationProgress.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationProgress.ps1)
