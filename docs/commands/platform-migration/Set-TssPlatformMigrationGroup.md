---
title: Set-TssPlatformMigrationGroup
parent: Platform Migration
grand_parent: Commands
---
# Set-TssPlatformMigrationGroup

## SYNOPSIS
Include or exclude groups from Delinea Platform migration

## SYNTAX

```
Set-TssPlatformMigrationGroup [-TssSession] <Session> -Id <Int32[]> [-DoNotMigrate]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Marks Secret Server groups to be migrated to the Delinea Platform, or with -DoNotMigrate excludes them from migration.
Search-TssPlatformMigrationGroup returns the groups and their current migration state.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformMigrationGroup -TssSession $session -Id 4, 7
```

Marks groups 4 and 7 to be migrated to the Platform

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigrationGroup -TssSession $session -Name 'Contractors' | Set-TssPlatformMigrationGroup -TssSession $session -DoNotMigrate
```

Excludes the groups named like Contractors from migration

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
Secret Server group IDs to update

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DoNotMigrate
Exclude the groups from migration.
Without it the groups are marked to migrate

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Returns True or False (the success flag of the response).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformMigrationGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformMigrationGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformMigrationGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformMigrationGroup.ps1)
