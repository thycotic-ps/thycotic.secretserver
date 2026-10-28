---
title: New-TssManualUpgradeAppZip
parent: Upgrade
grand_parent: Commands
---
# New-TssManualUpgradeAppZip

## SYNOPSIS
Generate the application ZIP for a manual upgrade

## SYNTAX

```
New-TssManualUpgradeAppZip [-TssSession] <Session> [-ImpersonationCredential <PSCredential>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds a ZIP of the changed application files of the staged upgrade patch in the manual upgrade temp folder.
FileName is the generated name: download it with Save-TssManualUpgradePackage.
Needs a staged upgrade patch.
Without one the call returns Success false and a StatusMessage.
Running it again regenerates the ZIP.
When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can.
A failed logon returns LoginFail true.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$zip = New-TssManualUpgradeAppZip -TssSession $session
Save-TssManualUpgradePackage -TssSession $session -FileName $zip.FileName -Output .
```

Generates the application ZIP and downloads it to the current folder

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

### -ImpersonationCredential
Windows account the server impersonates for disk access when the application pool identity lacks it

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.Upgrade.ManualUpgradeAppZip
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/New-TssManualUpgradeAppZip](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/New-TssManualUpgradeAppZip)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/New-TssManualUpgradeAppZip.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/New-TssManualUpgradeAppZip.ps1)
