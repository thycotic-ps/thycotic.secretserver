---
title: Set-TssProxySshClientOverride
parent: Proxy
grand_parent: Commands
---
# Set-TssProxySshClientOverride

## SYNOPSIS
Update an SSH terminal client override

## SYNTAX

```
Set-TssProxySshClientOverride [-TssSession] <Session> -Id <Int32> -IpAddressRange <String>
 -TerminalClientType <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the IP address range and list type of an SSH terminal client override.
Both values are required: the API saves the range and type sent as a whole.
Clients in the range are reset to match the override.
Use New-TssProxySshClientOverride to add an override and Remove-TssProxySshClientOverride to delete one.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxySshClientOverride -TssSession $session -Id 4 -IpAddressRange 10.0.0.0/24 -TerminalClientType BlockList
```

Moves override 4 to the block list for 10.0.0.0/24

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
Client override ID (ClientOverrideId in Search-TssProxySshClientOverride output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ClientOverrideId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClientOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClientOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClientOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClientOverride.ps1)
