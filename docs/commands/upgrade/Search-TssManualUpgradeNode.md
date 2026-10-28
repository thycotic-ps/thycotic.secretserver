---
title: Search-TssManualUpgradeNode
parent: Upgrade
grand_parent: Commands
---
# Search-TssManualUpgradeNode

## SYNOPSIS
List the nodes of a manual upgrade

## SYNTAX

```
Search-TssManualUpgradeNode [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns each node the manual (multi-step) upgrade tracks: installed version, last polled time, cluster membership, read-only mode, any error, and whether it is the node that answered the request.
Use it to confirm every node reached the target version before Complete-TssManualUpgrade.
Makes no changes.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssManualUpgradeNode -TssSession $session
```

Lists the nodes of the manual upgrade

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssManualUpgradeNode -TssSession $session | Where-Object Version -NE '12.3.000024'
```

Lists the nodes not yet on version 12.3.000024

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

### Thycotic.PowerShell.Upgrade.ManualUpgradeNode[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Search-TssManualUpgradeNode](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Search-TssManualUpgradeNode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Search-TssManualUpgradeNode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Search-TssManualUpgradeNode.ps1)
