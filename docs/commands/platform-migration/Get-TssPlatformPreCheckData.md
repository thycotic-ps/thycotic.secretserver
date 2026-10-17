---
title: Get-TssPlatformPreCheckData
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformPreCheckData

## SYNOPSIS
Get the Delinea Platform migration pre-check of users, groups and roles

## SYNTAX

```
Get-TssPlatformPreCheckData [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the migration pre-check summary of users, groups and roles: error, warning and information counts and the items that would prevent or affect their migration to the Delinea Platform.
The server marks this route deprecated in favor of the separate group, user and role pre-check routes.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformPreCheckData -TssSession $session
```

Returns the pre-check counts and items

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssPlatformPreCheckData -TssSession $session).Errors | Where-Object ErrorType -eq 'Error'
```

Returns the pre-check items that would prevent migration

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

### Thycotic.PowerShell.PlatformMigration.PlatformPreCheckData
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckData](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckData)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckData.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckData.ps1)
