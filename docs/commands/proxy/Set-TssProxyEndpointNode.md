---
title: Set-TssProxyEndpointNode
parent: Proxy
grand_parent: Commands
---
# Set-TssProxyEndpointNode

## SYNOPSIS
Set the proxy public host, bind address or jumpbox port range of a web node

## SYNTAX

```
Set-TssProxyEndpointNode [-TssSession] <Session> -Id <Int32> [-PublicHost <String>] [-BindIpAddress <String>]
 [-JumpboxAvailablePortRange <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the proxy endpoint of a Secret Server web node.
Only the parameters provided are changed.
Returns the proxy endpoint summary after the change.
Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxyEndpointNode -TssSession $session -Id 1 -BindIpAddress 10.0.0.15
```

Sets the bind address of the proxy on node 1

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
Web node ID (NodeId in Search-TssProxyEndpoint output)

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

### -PublicHost
Host name or address that clients use to reach the proxy on this node

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

### -BindIpAddress
IP address the proxy listens on for this node

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

### -JumpboxAvailablePortRange
Port range available on this node for SSH jumpbox port forwarding, for example 5000-5100

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

### Thycotic.PowerShell.Proxy.Endpoint
## NOTES
Requires TssSession object returned by New-TssSession

On-premises only: Secret Server Cloud has no web nodes to configure.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointNode](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointNode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointNode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointNode.ps1)
