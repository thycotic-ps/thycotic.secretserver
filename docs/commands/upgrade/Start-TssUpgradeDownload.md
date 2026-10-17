---
title: Start-TssUpgradeDownload
parent: Upgrade
grand_parent: Commands
---
# Start-TssUpgradeDownload

## SYNOPSIS
Download and stage the latest upgrade from the Delinea update server

## SYNTAX

```
Start-TssUpgradeDownload [-TssSession] <Session> [-EarlyAdopter] [-ImpersonationCredential <PSCredential>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Has the server download the latest upgrade package from the Delinea update server, unzip it, check its integrity, and stage it for Install-TssUpgrade or Start-TssUpgrade.
-EarlyAdopter downloads early adopter (pre-release) versions instead of generally available ones.
This is a real download on the server.
Get-TssUpgradeState shows whether a newer version is available (IsLatestVersion, LatestVersionToDownload).
When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can.
A failed logon returns LoginFail true.
Nothing is downloaded when the logon fails.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssUpgradeDownload -TssSession $session
```

Downloads and stages the latest generally available upgrade

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssUpgradeDownload -TssSession $session -EarlyAdopter
```

Downloads and stages the latest early adopter upgrade

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

### -EarlyAdopter
Download early adopter (pre-release) versions instead of generally available ones

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### Thycotic.PowerShell.Upgrade.Download
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgradeDownload](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgradeDownload)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgradeDownload.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgradeDownload.ps1)
