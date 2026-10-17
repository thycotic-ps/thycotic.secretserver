---
title: Get-TssServiceBusStatus
parent: Diagnostics
grand_parent: Commands
---
# Get-TssServiceBusStatus

## SYNOPSIS
Get the service buses of a Secret Server Cloud tenant

## SYNTAX

```
Get-TssServiceBusStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the Azure Service Bus namespaces the tenant uses to talk to its distributed engines: one object per service bus with its name and URL.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServiceBusStatus -TssSession $session
```

Get the service buses of the tenant

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

### Thycotic.PowerShell.Diagnostics.ServiceBus[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssServiceBusStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssServiceBusStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssServiceBusStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssServiceBusStatus.ps1)
