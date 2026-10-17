---
title: Start-TssUpgrade
parent: Upgrade
grand_parent: Commands
---
# Start-TssUpgrade

## SYNOPSIS
Install a staged Secret Server upgrade and wait for it to finish

## SYNTAX

```
Start-TssUpgrade [-TssSession] <Session> [-Download] [-EarlyAdopter] [-ExpectedVersion <String>]
 [-EnableReadOnlyMode] [-ImpersonationCredential <PSCredential>] [-TimeoutMinutes <Int32>]
 [-PollSeconds <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Runs an upgrade end to end and makes several calls: Get-TssUpgradeState for the starting version, Start-TssUpgradeDownload when -Download is set, Install-TssUpgrade, then Get-TssUpgradeStatus and Get-TssUpgradeState every -PollSeconds until the run ends, the version reaches -ExpectedVersion, or -TimeoutMinutes passes.
The package must already be staged (Start-TssUpgradeDownload or an upload through the web UI) unless -Download is set.
-EnableReadOnlyMode turns read-only mode on before the install and off after it (PATCH configuration/read-only-mode).
The web application recycles during the upgrade, so some polls get no answer.
That is expected: -Verbose shows each poll.
The session token must stay valid for the whole run; if it expires, check the outcome with Get-TssUpgradeStatus and a new session.
Returns the starting and final version, the last upgrade status, and whether the upgrade succeeded.
A failed or timed out upgrade also writes an error.
An upgrade cannot be undone.
Back up the database first.
Requires the Administer Configuration permission.
-EnableReadOnlyMode also needs the Administer Maintenance Mode permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssUpgrade -TssSession $session -ExpectedVersion 12.3.000024
```

Installs the staged upgrade after asking for confirmation and waits until the server runs version 12.3.000024

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssUpgrade -TssSession $session -Download -EnableReadOnlyMode -TimeoutMinutes 40 -Confirm:$false
```

Downloads the latest upgrade, installs it in read-only mode without a confirmation prompt, and waits up to 40 minutes

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

### -Download
Download and stage the latest upgrade from the Delinea update server first (Start-TssUpgradeDownload)

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

### -EarlyAdopter
With -Download, download early adopter (pre-release) versions instead of generally available ones

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

### -ExpectedVersion
Version the server must run when the upgrade is done, for example 12.3.000024.
Without it, success means the run ended successfully on a new version

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableReadOnlyMode
Turn read-only mode on before the install and off after it.
The upgrade is not started when read-only mode cannot be turned on, and read-only mode stays on when the upgrade does not finish within -TimeoutMinutes

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

### -TimeoutMinutes
Minutes to wait for the upgrade to finish, 20 by default

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### -PollSeconds
Seconds between progress checks, 10 by default

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 10
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

### Thycotic.PowerShell.Upgrade.Result
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgrade](https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgrade)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgrade.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgrade.ps1)
