---
title: Confirm-TssManualUpgradeStaging
parent: Upgrade
grand_parent: Commands
---
# Confirm-TssManualUpgradeStaging

## SYNOPSIS
Record that the staging test of a manual upgrade passed

## SYNTAX

```
Confirm-TssManualUpgradeStaging [-TssSession] <Session> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Records the staging test step of the manual (multi-step) upgrade: the operator confirmed the staged upgrade works before it is promoted.
Each call writes an audit entry and returns true.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Confirm-TssManualUpgradeStaging -TssSession $session
```

Records that the staging test of the manual upgrade passed

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Confirm-TssManualUpgradeStaging](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Confirm-TssManualUpgradeStaging)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Confirm-TssManualUpgradeStaging.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Confirm-TssManualUpgradeStaging.ps1)
