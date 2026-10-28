---
title: Get-TssLauncherAgentCollection
parent: Launcher Agents
grand_parent: Commands
---
# Get-TssLauncherAgentCollection

## SYNOPSIS
Get a launcher agent collection

## SYNTAX

```
Get-TssLauncherAgentCollection [-TssSession] <Session> -Id <Int32[]> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Get an Advanced Session Recording launcher agent collection by Id, active or inactive.
An unknown Id returns nothing.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgentCollection -TssSession $session -Id 1
```

Get launcher agent collection 1, active or not

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

### -Id
Launcher agent collection Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeInactive
Sent to Secret Server as includeInactive.
Secret Server returns an inactive collection by Id with or without it

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.LauncherAgents.Collection
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollection.ps1)
