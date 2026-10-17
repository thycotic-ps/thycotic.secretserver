---
title: Get-TssManualUpgradeState
parent: Upgrade
grand_parent: Commands
---
# Get-TssManualUpgradeState

## SYNOPSIS
Get the manual upgrade state

## SYNTAX

```
Get-TssManualUpgradeState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the readiness of a manual (multi-step) upgrade: installed version, staged patch, read-only mode and version mismatch flags, application pool disk access, file locations, and the progress of each manual step.
Makes no changes.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssManualUpgradeState -TssSession $session
```

Returns the manual upgrade state

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssManualUpgradeState -TssSession $session | Select-Object CurrentVersion, IsSqlScriptGenerated, AreSqlDeltasVerified, IsApplicationZipFileDownloaded
```

Shows which manual upgrade steps are done

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

### Thycotic.PowerShell.Upgrade.ManualUpgradeState
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssManualUpgradeState](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssManualUpgradeState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssManualUpgradeState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssManualUpgradeState.ps1)
