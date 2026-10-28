---
title: Get-TssLauncherAgentCollectionStub
parent: Launcher Agents
grand_parent: Commands
---
# Get-TssLauncherAgentCollectionStub

## SYNOPSIS
Get a launcher agent collection stub

## SYNTAX

```
Get-TssLauncherAgentCollectionStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get an empty launcher agent collection with the server defaults, to fill in before New-TssLauncherAgentCollection.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$stub = Get-TssLauncherAgentCollectionStub -TssSession $session
New-TssLauncherAgentCollection -TssSession $session -Name 'Jump hosts' -RecordKeystrokes:$stub.RecordKeystrokes -RecordStandaloneSessions:$stub.RecordStandaloneSessions
```

Create a collection with the server default recording settings

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

### Thycotic.PowerShell.LauncherAgents.Collection
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionStub.ps1)
