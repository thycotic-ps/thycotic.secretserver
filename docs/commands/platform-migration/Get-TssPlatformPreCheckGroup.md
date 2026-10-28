---
title: Get-TssPlatformPreCheckGroup
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformPreCheckGroup

## SYNOPSIS
Get the group pre-check summary for a Platform migration

## SYNTAX

```
Get-TssPlatformPreCheckGroup [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the result of the pre-check Secret Server runs on its groups before they migrate to the Delinea Platform: error, warning and information counts, whether any group has an empty group type, and the errors found.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformPreCheckGroup -TssSession $session | Select-Object -ExpandProperty Errors
```

List the errors the group pre-check found

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckGroup.ps1)
