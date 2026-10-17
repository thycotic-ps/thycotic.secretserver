---
title: New-TssProxyRdpCertificate
parent: Proxy
grand_parent: Commands
---
# New-TssProxyRdpCertificate

## SYNOPSIS
Generate a new RDP proxy server certificate

## SYNTAX

```
New-TssProxyRdpCertificate [-TssSession] <Session> -DnsName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates a new self-signed RDP proxy server certificate for the DNS name provided, replaces the current certificate, and returns the RDP proxy configuration.
RDP clients that pinned the previous certificate see a certificate warning on their next connection.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
 RdpServerCertificate carries the new certificate including its private key.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssProxyRdpCertificate -TssSession $session -DnsName rdp.example.com | Out-Null
```

Replaces the RDP proxy certificate with a new one for rdp.example.com, without returning it

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

### -DnsName
DNS name used as the subject of the new self-signed certificate

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.Proxy.RdpConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxyRdpCertificate](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxyRdpCertificate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxyRdpCertificate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxyRdpCertificate.ps1)
