---
title: Set-TssProxyEndpointSite
parent: Proxy
grand_parent: Commands
---
# Set-TssProxyEndpointSite

## SYNOPSIS
Set the SSH proxy, RDP proxy and RDP gateway settings of a site

## SYNTAX

```
Set-TssProxyEndpointSite [-TssSession] <Session> -Id <Int32> [-EnableSshProxy] [-SshProxyPort <Int32>]
 [-SshProxyPortInherited] [-SshJumpboxAvailablePortRange <String>] [-EnableRdpProxy] [-RdpProxyPort <Int32>]
 [-RdpProxyPortInherited] [-EnableRdpGateway] [-RdpGatewayPort <Int32>] [-RdpGatewayPortInherited]
 [-RdpProxyCertificateSecretId <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the proxy endpoint of a distributed engine site.
Only the parameters provided are changed.
The API clears the site RDP proxy certificate secret when the request omits it, so this command reads the current value first and sends it back unless -RdpProxyCertificateSecretId is provided.
A site port only applies when the matching Inherited flag is false.
Returns the proxy endpoint summary after the change.
Requires the Administer Distributed Engine and Administer Proxying Configuration permissions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxyEndpointSite -TssSession $session -Id 3 -EnableSshProxy -SshProxyPort 2222 -SshProxyPortInherited:$false
```

Enables the SSH proxy on site 3 with its own port 2222

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxyEndpointSite -TssSession $session -Id 3 -EnableRdpProxy:$false
```

Turns the RDP proxy off for site 3

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
Site ID (SiteId in Search-TssProxyEndpoint output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SiteId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnableSshProxy
Enable or disable the SSH proxy for the site

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

### -SshProxyPort
SSH proxy port for the site

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

### -SshProxyPortInherited
Use the global SSH proxy port.
Pass -SshProxyPortInherited:$false with -SshProxyPort to set a site port

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

### -SshJumpboxAvailablePortRange
Port range available for SSH jumpbox port forwarding, for example 5000-5100

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

### -EnableRdpProxy
Enable or disable the RDP proxy for the site

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

### -RdpProxyPort
RDP proxy port for the site

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

### -RdpProxyPortInherited
Use the global RDP proxy port.
Pass -RdpProxyPortInherited:$false with -RdpProxyPort to set a site port

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

### -EnableRdpGateway
Enable or disable the RDP gateway for the site

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

### -RdpGatewayPort
RDP gateway port for the site (1-65535)

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

### -RdpGatewayPortInherited
Use the global RDP gateway port.
Pass -RdpGatewayPortInherited:$false with -RdpGatewayPort to set a site port

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

### -RdpProxyCertificateSecretId
ID of the secret holding the RDP proxy certificate for the site.
Pass 0 to clear it.
When omitted, the current certificate secret is kept

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

### Thycotic.PowerShell.Proxy.Endpoint
## NOTES
Requires TssSession object returned by New-TssSession

The local (web) site cannot be changed with this command: the API denies it.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointSite](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyEndpointSite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointSite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyEndpointSite.ps1)
