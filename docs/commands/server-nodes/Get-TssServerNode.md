---
title: Get-TssServerNode
parent: Server Nodes
grand_parent: Commands
---
# Get-TssServerNode

## SYNOPSIS
Get a Secret Server web node

## SYNTAX

```
Get-TssServerNode [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets one or more Secret Server web nodes by ID: machine name, version, cluster membership, enabled worker roles and their errors, read-only mode and log level.
Search-TssServerNode lists every node.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerNode -TssSession $session -Id 2
```

Gets server node 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssServerNode -TssSession $session | Get-TssServerNode -TssSession $session | Where-Object EngineWorkerError
```

Gets every node and shows those reporting an engine worker error

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
Server node ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: NodeId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ServerNodes.Node
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNode](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNode.ps1)
