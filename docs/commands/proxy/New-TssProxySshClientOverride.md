---
title: New-TssProxySshClientOverride
parent: Proxy
grand_parent: Commands
---
# New-TssProxySshClientOverride

## SYNOPSIS
Add an SSH terminal client override

## SYNTAX

```
New-TssProxySshClientOverride [-TssSession] <Session> -IpAddressRange <String> -TerminalClientType <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an IP address range that is always on the SSH terminal allow list or block list.
Clients in the range are reset to match the override.
Returns the new override.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssProxySshClientOverride -TssSession $session -IpAddressRange 203.0.113.0/24 -TerminalClientType BlockList
```

Always blocks SSH terminal clients from 203.0.113.0/24

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

### -IpAddressRange
IP address or range the override applies to, for example 10.0.0.0/24 or 10.0.0.1-10.0.0.50

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

### -TerminalClientType
Put the range on the allow list or the block list

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

### Thycotic.PowerShell.Proxy.SshClientOverride
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshClientOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshClientOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshClientOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshClientOverride.ps1)
