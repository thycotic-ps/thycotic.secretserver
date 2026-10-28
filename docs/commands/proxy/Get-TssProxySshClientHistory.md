---
title: Get-TssProxySshClientHistory
parent: Proxy
grand_parent: Commands
---
# Get-TssProxySshClientHistory

## SYNOPSIS
Get the authentication history of SSH terminal clients

## SYNTAX

```
Get-TssProxySshClientHistory [-TssSession] <Session> [-IpAddress <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns SSH terminal client authentication attempts: client IP address, engine identity GUID, date, and authentication result.
Secret Server filters this list by client IP address only.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxySshClientHistory -TssSession $session -IpAddress 10.0.0.25
```

Returns the authentication attempts from 10.0.0.25

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

### -IpAddress
Return only entries from this client IP address

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Proxy.SshClientHistory[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshClientHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshClientHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshClientHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshClientHistory.ps1)
