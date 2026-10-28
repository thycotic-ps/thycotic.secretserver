---
title: Get-TssPlatformMigration
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformMigration

## SYNOPSIS
Get a Delinea Platform migration run

## SYNTAX

```
Get-TssPlatformMigration [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one Delinea Platform data migration run: status, start and end dates and the success and error counts per object type.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformMigration -TssSession $session -Id 3
```

Returns migration run 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformMigration -TssSession $session | Get-TssPlatformMigration -TssSession $session
```

Returns the detail of every migration run

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
Migration run ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: MigrationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformMigration.Migration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigration](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigration.ps1)
