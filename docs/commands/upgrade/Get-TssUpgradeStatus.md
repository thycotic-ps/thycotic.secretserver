---
title: Get-TssUpgradeStatus
parent: Upgrade
grand_parent: Commands
---
# Get-TssUpgradeStatus

## SYNOPSIS
Get the progress of the most recent upgrade

## SYNTAX

```
Get-TssUpgradeStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the progress of the most recent upgrade (or initial install) run.
Status holds the start and end, whether it is still running, whether it succeeded, any exception, and the per-task breakdown.
Also reports whether the instance has other nodes and whether read-only mode is enabled.
Makes no changes.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUpgradeStatus -TssSession $session
```

Returns the progress of the most recent upgrade

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssUpgradeStatus -TssSession $session).Status.tasks | Select-Object displayName, success
```

Lists each task of the most recent upgrade and whether it succeeded

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

### Thycotic.PowerShell.Upgrade.UpgradeStatus
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeStatus.ps1)
