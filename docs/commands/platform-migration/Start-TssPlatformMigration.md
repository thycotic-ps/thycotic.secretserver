---
title: Start-TssPlatformMigration
parent: Platform Migration
grand_parent: Commands
---
# Start-TssPlatformMigration

## SYNOPSIS
Start a migration of users and groups to the Delinea Platform

## SYNTAX

```
Start-TssPlatformMigration [-TssSession] <Session> -Name <String> [-UserId <Int32[]>] [-GroupId <Int32[]>]
 [-MigrateUserTotpSettings] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a Delinea Platform data migration run for the given Secret Server users and groups.
The run continues in the background.
Follow it with Get-TssPlatformMigrationProgress and review it with Search-TssPlatformMigration and Search-TssPlatformMigrationLog.
Migration creates or updates identities on the Platform tenant and changes how the migrated users sign in.
It cannot be undone from Secret Server.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssPlatformMigration -TssSession $session -Name 'Pilot users' -UserId 15, 16 -MigrateUserTotpSettings
```

Starts a migration of users 15 and 16 with their TOTP settings, after confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$groups = Search-TssPlatformMigrationGroup -TssSession $session -MigrationState NotMigrated
Start-TssPlatformMigration -TssSession $session -Name 'Remaining groups' -GroupId $groups.GroupId -WhatIf
```

Shows the request that would start a migration of every group not yet migrated

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

### -Name
Name of the migration run

```yaml
Type: String
Parameter Sets: (All)
Aliases: MigrationName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId
Secret Server user IDs to migrate

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupId
Secret Server group IDs to migrate

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MigrateUserTotpSettings
Also migrate the TOTP (authenticator) settings of each user

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Start-TssPlatformMigration](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Start-TssPlatformMigration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Start-TssPlatformMigration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Start-TssPlatformMigration.ps1)
