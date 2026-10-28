---
title: Search-TssProxySshClientOverride
parent: Proxy
grand_parent: Commands
---
# Search-TssProxySshClientOverride

## SYNOPSIS
Get the SSH terminal client overrides

## SYNTAX

```
Search-TssProxySshClientOverride [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns every SSH terminal client override: an IP address range that is always on the allow list or the block list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssProxySshClientOverride -TssSession $session
```

Returns the client overrides

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

### Thycotic.PowerShell.Proxy.SshClientOverride[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClientOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClientOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClientOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClientOverride.ps1)
