---
title: Set-TssUpgradeIgnoreVersionMismatch
parent: Configurations
grand_parent: Commands
---
# Set-TssUpgradeIgnoreVersionMismatch

## SYNOPSIS
Turn the ignore version mismatch on upgrade setting on or off

## SYNTAX

```
Set-TssUpgradeIgnoreVersionMismatch [-TssSession] <Session> -Enabled <Boolean>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets whether an upgrade ignores a mismatch between the application version and the version the database expects.
Turn it on only to override that safety check during an upgrade, and off again afterwards.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUpgradeIgnoreVersionMismatch -TssSession $session -Enabled $true
```

Turns on ignore version mismatch on upgrade

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUpgradeIgnoreVersionMismatch -TssSession $session -Enabled $false
```

Turns the setting off again after the upgrade

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

### -Enabled
True turns the setting on, false turns it off

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssUpgradeIgnoreVersionMismatch](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssUpgradeIgnoreVersionMismatch)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssUpgradeIgnoreVersionMismatch.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssUpgradeIgnoreVersionMismatch.ps1)
