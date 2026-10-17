---
title: Get-TssProxyState
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyState

## SYNOPSIS
Get the proxy state

## SYNTAX

```
Get-TssProxyState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the proxy state.
ShowLogs is True on Secret Server on-premises, where proxy operational logs are available, and False on Secret Server Cloud.
Requires the View Proxying Configuration or Administer Proxying Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxyState -TssSession $session
```

Returns the proxy state

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

### Thycotic.PowerShell.Proxy.State
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyState](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyState.ps1)
