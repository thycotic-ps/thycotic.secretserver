---
title: Set-TssPlatformUsersToMigrate
parent: Platform Migration
grand_parent: Commands
---
# Set-TssPlatformUsersToMigrate

## SYNOPSIS
Mark Secret Server users to migrate to the Platform

## SYNTAX

```
Set-TssPlatformUsersToMigrate [-TssSession] <Session> -UserId <Int32[]> -Migrate <Boolean>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Mark Secret Server users to migrate, or not to migrate, to the Delinea Platform in the next Platform migration.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformUsersToMigrate -TssSession $session -UserId 4, 7 -Migrate $true
```

Mark users 4 and 7 to migrate

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformUsersToMigrate -TssSession $session -UserId 7 -Migrate $false
```

Exclude user 7 from the migration

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

### -UserId
Secret Server user Ids to mark

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Migrate
True to migrate the users, False to leave them out of the migration

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.PlatformMigration.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformUsersToMigrate](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformUsersToMigrate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformUsersToMigrate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformUsersToMigrate.ps1)
