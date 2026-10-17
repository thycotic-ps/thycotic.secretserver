---
title: Set-TssServerNodeConfiguration
parent: Server Nodes
grand_parent: Commands
---
# Set-TssServerNodeConfiguration

## SYNOPSIS
Update the roles, cluster membership, read-only mode and log level of a server node

## SYNTAX

```
Set-TssServerNodeConfiguration [-TssSession] <Session> -Id <Int32> [-ChangeRootLogLevel]
 [-EnableBackgroundWorker] [-EnableEngineWorker] [-EnableSessionRecordingWorker] [-InCluster]
 [-LogLevel <String>] [-ReadonlyModeEnabled] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the configuration of a Secret Server web node.
The server expects the complete node configuration, so this cmdlet reads the node with Get-TssServerNode first and changes only the parameters provided; every other setting keeps its current value.
Unlike Update-TssServerNode, which sends a partial body with PUT, this cmdlet sends the full configuration with POST.
Returns the result the server sends back: True when it accepted the configuration, also when nothing changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssServerNodeConfiguration -TssSession $session -Id 2 -EnableSessionRecordingWorker:$false
```

Turns off the session recording worker role on node 2 and keeps every other setting

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssServerNode -TssSession $session | Set-TssServerNodeConfiguration -TssSession $session -LogLevel Debug -WhatIf
```

Shows the request that would set every node to Debug logging, without sending it

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
Type: Int32
Parameter Sets: (All)
Aliases: NodeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ChangeRootLogLevel
Also apply the log level to the root logger; needs a log level on the node or -LogLevel

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

### -EnableBackgroundWorker
Enable the background worker role

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

### -EnableEngineWorker
Enable the engine worker role

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

### -EnableSessionRecordingWorker
Enable the session recording worker role

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

### -InCluster
Include the node in the cluster

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

### -LogLevel
Node log level: All, Debug, Info, Warn, Error or Off

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

### -ReadonlyModeEnabled
Put the node in read-only mode

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeConfiguration.ps1)
