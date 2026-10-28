---
title: Set-TssServerNodeState
parent: Server Nodes
grand_parent: Commands
---
# Set-TssServerNodeState

## SYNOPSIS
Turn clustering on or off

## SYNTAX

```
Set-TssServerNodeState [-TssSession] <Session> [-EnableClustering]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Turns clustering on or off for the Secret Server installation.
Returns the new state, including RequiresRestart when the web nodes must restart for the change to apply.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssServerNodeState -TssSession $session -EnableClustering
```

Turns on clustering after confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssServerNodeState -TssSession $session -EnableClustering:$false -WhatIf
```

Shows the request that would turn off clustering, without sending it

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

### -EnableClustering
Enable clustering

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

### Thycotic.PowerShell.ServerNodes.StateUpdate
## NOTES
Requires TssSession object returned by New-TssSession

Changes server-wide state and may recycle the web application, so it asks for confirmation by default.

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeState](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeState.ps1)
