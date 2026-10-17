---
title: New-TssProxySshKey
parent: Proxy
grand_parent: Commands
---
# New-TssProxySshKey

## SYNOPSIS
Generate a new SSH proxy host key

## SYNTAX

```
New-TssProxySshKey [-TssSession] <Session> [-Algorithm <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates a new SSH proxy host key, replaces the current key, and returns the SSH proxy configuration with the new key and fingerprint.
SSH clients that stored the previous host key in known_hosts must update it before they reconnect.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
SshHostKey is the SSH proxy host private key in PEM form.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(New-TssProxySshKey -TssSession $session -Algorithm RSA).SshProxyHostFingerprint
```

Replaces the SSH proxy host key with a new RSA key and returns the new fingerprint

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

### -Algorithm
Key algorithm.
The server uses ECDSA when omitted

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

### Thycotic.PowerShell.Proxy.SshConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshKey.ps1)
