---
title: Get-TssProxyAudit
parent: Proxy
grand_parent: Commands
---
# Get-TssProxyAudit

## SYNOPSIS
Get the proxy audit log

## SYNTAX

```
Get-TssProxyAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the proxy audit log entries: the date, the user display name, the action, notes and the client IP address.
Requires the Administer Proxying Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssProxyAudit -TssSession $session
```

Returns the proxy audit entries

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

### Thycotic.PowerShell.Proxy.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyAudit.ps1)
