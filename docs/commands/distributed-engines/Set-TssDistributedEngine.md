# Set-TssDistributedEngine

## SYNOPSIS
Set Distributed Engine configuration settings

## SYNTAX

```
Set-TssDistributedEngine [-TssSession] <Session> [-Enable] [-TransportType <EngineAzServiceBusType>]
 [-CallbackPort <Int32>] [-CallbackUrl <String>] [-Protocol <EngineProtocol>] [-SiteConnectorId <Int32>]
 [-HeartbeatTimeToLive <Int32>] [-HeartbeatRetry <Int32>] [-RpcTimeToLive <Int32>] [-RpcRetry <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set Distributed Engine configuration settings

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDistributedEngine -TssSession $session -Enable
```

Enable Distributed Engine feature in Secret Server

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

### -Enable
Enable Distributed Engine feature in Secret Server

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

### -TransportType
Azure Service Bus Transport Type, SSC only (allowed: Amqp, AmqpWebSockets)

```yaml
Type: EngineAzServiceBusType
Parameter Sets: (All)
Aliases: AzureServiceBusTransportType
Accepted values: Amqp, AmqpWebSockets

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CallbackPort
Callback port

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CallbackUrl
Callback URL

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

### -Protocol
Protocol used by the Distributed Engines (allowed: Http, Https, Tcp)

```yaml
Type: EngineProtocol
Parameter Sets: (All)
Aliases:
Accepted values: Http, Https, Tcp

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteConnectorId
Site Connector ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatTimeToLive
How long before a Secret Heartbeat message expires (in mintues)
**Retry time must be higher**

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatRetry
How long before a Secret Heartbeat messsage will be resent (in minutes)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpcTimeToLive
How long before a Secret Password Change message expires (in minutes)
**Retry time must be higher**

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpcRetry
How long before a Secret Password Change message will be resent (in minutes)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngine](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngine)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngine.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngine.ps1)

