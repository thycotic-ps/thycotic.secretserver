---
title: Set-TssDistributedEngineLatestVersion
parent: Distributed Engines
grand_parent: Commands
---
# Set-TssDistributedEngineLatestVersion

## SYNOPSIS
Refresh the latest Distributed Engine version stored in the Distributed Engine configuration

## SYNTAX

```
Set-TssDistributedEngineLatestVersion [-TssSession] <Session> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reads the latest Distributed Engine version file on the Secret Server web server and, when that version is allowed and not lower than the minimum required engine version, stores it as the latest version in the Distributed Engine configuration.
When automatic engine updates are on (autoUpdateEnginesVersion), it also makes that version the minimum required engine version.
Takes no input. LatestVersion in the result is the minimum required engine version, not the stored latest version: with automatic updates off it stays the same, so read latestDistributedEnginesVersion from Get-TssDistributedEngineConfiguration for the latest version.
An empty LatestVersion means the request failed on the server; the Secret Server log has the reason.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDistributedEngineLatestVersion -TssSession $session
(Get-TssDistributedEngineConfiguration -TssSession $session).latestDistributedEnginesVersion
```

Refreshes the latest engine version in the Distributed Engine configuration, then reads the stored latest version

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

### Thycotic.PowerShell.DistributedEngines.EngineLatestVersion
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineLatestVersion](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineLatestVersion)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineLatestVersion.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineLatestVersion.ps1)
