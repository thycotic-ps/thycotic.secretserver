---
title: Set-TssProxyEndpointEngine
parent: Proxy
grand_parent: Commands
---
# Set-TssProxyEndpointEngine

## SYNOPSIS
Set the proxy public host or bind address of a distributed engine

## SYNTAX

```
Set-TssProxyEndpointEngine [-TssSession] <Session> -Id <Int32> [-PublicHost <String>] [-BindIpAddress <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the proxy endpoint of a distributed engine.
Only the parameters provided are changed.
Returns the proxy endpoint summary after the change.
Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxyEndpointEngine -TssSession $session -Id 3 -PublicHost proxy.example.com
```

Sets the public host clients use to reach the proxy on engine 3

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
Distributed engine ID (EngineId in Search-TssProxyEndpoint output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: EngineId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PublicHost
Host name or address that clients use to reach the proxy on this engine

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
IP address the proxy listens on for this engine

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

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointEngine](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointEngine)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointEngine.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointEngine.ps1)
