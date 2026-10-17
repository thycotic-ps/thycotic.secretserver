---
title: Get-TssProxyEndpointNotification
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyEndpointNotification

## SYNOPSIS
Get the proxy endpoint warning message

## SYNTAX

```
Get-TssProxyEndpointNotification [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the warning text Secret Server shows about the current proxy endpoint configuration, or an empty string when there is nothing to report.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxyEndpointNotification -TssSession $session
```

Returns the proxy endpoint warning text

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyEndpointNotification](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyEndpointNotification)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyEndpointNotification.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyEndpointNotification.ps1)
