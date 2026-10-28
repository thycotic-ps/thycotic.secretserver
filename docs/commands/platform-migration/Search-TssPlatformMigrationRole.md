---
title: Search-TssPlatformMigrationRole
parent: Platform Migration
grand_parent: Commands
---
# Search-TssPlatformMigrationRole

## SYNOPSIS
Search the Secret Server roles in scope for Delinea Platform migration

## SYNTAX

```
Search-TssPlatformMigrationRole [-TssSession] <Session> [-Name <String>] [-RoleId <Int32[]>]
 [-UserId <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Secret Server roles in scope for migration to the Delinea Platform, with their migration state.
The endpoint is a read even though it is called with POST (the filter is sent in the request body).
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigrationRole -TssSession $session
```

Returns every role with its migration state, permission count and assignment count

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigrationRole -TssSession $session -UserId 15
```

Returns the roles assigned to user 15

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
Return roles whose name matches this text

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

### -RoleId
Return only these role IDs

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

### -UserId
Return the roles assigned to these user IDs

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformMigration.MigrationRole[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationRole.ps1)
