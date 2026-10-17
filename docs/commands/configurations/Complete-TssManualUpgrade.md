---
title: Complete-TssManualUpgrade
parent: Configurations
grand_parent: Commands
---
# Complete-TssManualUpgrade

## SYNOPSIS
Mark a manual upgrade as finished

## SYNTAX

```
Complete-TssManualUpgrade [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Marks the manual (multi-step) upgrade as finished once every node runs the new version.
Run Search-TssManualUpgradeNode first to confirm every node reached the target version.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssManualUpgradeNode -TssSession $session | Select-Object MachineName, Version
Complete-TssManualUpgrade -TssSession $session
```

Shows the version on every node, then marks the manual upgrade as finished

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

### Thycotic.PowerShell.Configuration.UpgradeFlag
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Complete-TssManualUpgrade](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Complete-TssManualUpgrade)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Complete-TssManualUpgrade.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Complete-TssManualUpgrade.ps1)
