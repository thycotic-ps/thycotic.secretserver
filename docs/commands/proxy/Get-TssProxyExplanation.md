---
title: Get-TssProxyExplanation
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyExplanation

## SYNOPSIS
Get the explanations of the SSH proxy, SSH terminal and RDP proxy features

## SYNTAX

```
Get-TssProxyExplanation [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the help text Secret Server shows on the proxy configuration pages, one property per feature.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssProxyExplanation -TssSession $session).RdpProxyExplanation
```

Returns the RDP proxy explanation text

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

### Thycotic.PowerShell.Proxy.Explanation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyExplanation](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyExplanation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyExplanation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyExplanation.ps1)
