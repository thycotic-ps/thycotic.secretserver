---
title: Get-TssProxyRdpConfiguration
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyRdpConfiguration

## SYNOPSIS
Get the RDP proxy configuration

## SYNTAX

```
Get-TssProxyRdpConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the RDP proxy configuration: proxy and gateway enablement and ports, remote host validation, SSPI authentication method, log retention and the RDP server certificate.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
 RdpServerCertificate carries the RDP proxy server certificate as stored, including its private key.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxyRdpConfiguration -TssSession $session | Select-Object EnableRdpProxy, RdpProxyPort
```

Returns whether the RDP proxy is enabled and its port

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

### Thycotic.PowerShell.Proxy.RdpConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyRdpConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyRdpConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyRdpConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyRdpConfiguration.ps1)
