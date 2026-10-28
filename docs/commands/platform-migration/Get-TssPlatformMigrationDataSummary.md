---
title: Get-TssPlatformMigrationDataSummary
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformMigrationDataSummary

## SYNOPSIS
Get the Delinea Platform migration totals

## SYNTAX

```
Get-TssPlatformMigrationDataSummary [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the totals of users, groups and roles: in Secret Server, migrated to the Delinea Platform and excluded, plus the counts of the last migration run.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformMigrationDataSummary -TssSession $session
```

Returns the migration totals

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$summary = Get-TssPlatformMigrationDataSummary -TssSession $session
$summary.TotalUsers - $summary.MigratedUsers - $summary.ExcludedUserCount
```

Returns the number of users still to migrate

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformMigration.DataSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationDataSummary](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationDataSummary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationDataSummary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationDataSummary.ps1)
