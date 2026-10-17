---
title: Get-TssServerNodeState
parent: Server Nodes
grand_parent: Commands
---
# Get-TssServerNodeState

## SYNOPSIS
Get the clustering and SQL Server replication state

## SYNTAX

```
Get-TssServerNodeState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets whether clustering is enabled, whether SQL Server replication is enabled and whether the license allows SQL Server replication.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerNodeState -TssSession $session
```

Gets the clustering and replication state

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

### Thycotic.PowerShell.ServerNodes.State
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeState](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeState.ps1)
