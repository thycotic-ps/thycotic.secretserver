---
title: Get-TssPlatformPreCheckUser
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformPreCheckUser

## SYNOPSIS
Get the user pre-check summary for a Platform migration

## SYNTAX

```
Get-TssPlatformPreCheckUser [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the result of the pre-check Secret Server runs on its users before they migrate to the Delinea Platform: error, warning and information counts and the errors found.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssPlatformPreCheckUser -TssSession $session).ErrorCount
```

Show how many users fail the pre-check

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

### Thycotic.PowerShell.PlatformMigration.PreCheckSummary
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckUser.ps1)
