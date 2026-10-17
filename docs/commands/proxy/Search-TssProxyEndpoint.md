---
title: Search-TssProxyEndpoint
parent: Proxy
grand_parent: Commands
---
# Search-TssProxyEndpoint

## SYNOPSIS
Get the proxy endpoints of every site, engine and node

## SYNTAX

```
Search-TssProxyEndpoint [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns one object with the global SSH proxy, RDP proxy and RDP gateway settings plus the proxy configuration of each site (Sites), distributed engine (Engines) and web node (Nodes).
Use the SiteId, EngineId or NodeId of an entry with Set-TssProxyEndpointSite, Set-TssProxyEndpointEngine or Set-TssProxyEndpointNode.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssProxyEndpoint -TssSession $session
```

Returns the proxy endpoint summary

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Search-TssProxyEndpoint -TssSession $session).Sites
```

Lists the proxy settings of each site

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

### Thycotic.PowerShell.Proxy.Endpoint
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxyEndpoint](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxyEndpoint)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxyEndpoint.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxyEndpoint.ps1)
