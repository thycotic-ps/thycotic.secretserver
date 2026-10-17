---
title: Install-TssUpgrade
parent: Upgrade
grand_parent: Commands
---
# Install-TssUpgrade

## SYNOPSIS
Install a staged Secret Server upgrade

## SYNTAX

```
Install-TssUpgrade [-TssSession] <Session> [-ImpersonationCredential <PSCredential>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts the install of the upgrade package staged by Start-TssUpgradeDownload or uploaded through the web UI.
The upgrade runs in the background on the server and this call returns once it has started: UpgradeStartSuccess is true when it started.
A missing or broken staged package fails later, in the background run, so poll Get-TssUpgradeStatus (Start-TssUpgrade does this for you).
An upgrade cannot be undone.
Back up the database first.
When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can.
A failed logon returns LoginFail true.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Install-TssUpgrade -TssSession $session
```

Starts the install of the staged upgrade after asking for confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$appPoolCred = Get-Credential
Install-TssUpgrade -TssSession $session -ImpersonationCredential $appPoolCred -Confirm:$false
```

Starts the install as a Windows account that can write to the application folder, without a confirmation prompt

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

### Thycotic.PowerShell.Upgrade.Install
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Install-TssUpgrade](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Install-TssUpgrade)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Install-TssUpgrade.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Install-TssUpgrade.ps1)
