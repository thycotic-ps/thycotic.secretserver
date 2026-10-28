---
title: Get-TssProxySshConfiguration
parent: Proxy
grand_parent: Commands
---
# Get-TssProxySshConfiguration

## SYNOPSIS
Get the SSH proxy configuration

## SYNTAX

```
Get-TssProxySshConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH proxy and SSH terminal configuration: enablement, ports, tunneling, banners, inactivity timeouts, password hiding, block listing, jumpbox port range and log retention.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
SshHostKey is the SSH proxy host private key in PEM form.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxySshConfiguration -TssSession $session | Select-Object EnableSshProxy, SshProxyPort, EnableSshTerminal
```

Returns whether the SSH proxy and terminal are enabled, without the host key

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

### Thycotic.PowerShell.Proxy.SshConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshConfiguration.ps1)
