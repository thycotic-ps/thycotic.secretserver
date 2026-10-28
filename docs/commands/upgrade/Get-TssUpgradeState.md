---
title: Get-TssUpgradeState
parent: Upgrade
grand_parent: Commands
---
# Get-TssUpgradeState

## SYNOPSIS
Get the upgrade state

## SYNTAX

```
Get-TssUpgradeState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the readiness of an automatic upgrade: installed version, latest version available to download, whether a staged version can be installed, read-only mode capability, database name and server, and application pool disk access.
Makes no changes.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUpgradeState -TssSession $session
```

Returns the upgrade state

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUpgradeState -TssSession $session | Select-Object CurrentVersion, LatestVersionToDownload, CanInstallDownloadedVersion
```

Shows the installed version, the latest version available and whether a staged version can be installed

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

### Thycotic.PowerShell.Upgrade.State
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeState](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Get-TssUpgradeState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Get-TssUpgradeState.ps1)
