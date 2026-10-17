---
title: Get-TssProxyRdpNotification
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyRdpNotification

## SYNOPSIS
Get the RDP proxy status message

## SYNTAX

```
Get-TssProxyRdpNotification [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the RDP proxy status text Secret Server shows, for example how many sites and engines run the RDP proxy and any warning.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxyRdpNotification -TssSession $session
```

Returns the RDP proxy status text

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyRdpNotification](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyRdpNotification)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyRdpNotification.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyRdpNotification.ps1)
