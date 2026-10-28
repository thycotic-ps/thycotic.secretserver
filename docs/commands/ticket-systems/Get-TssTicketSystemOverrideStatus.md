---
title: Get-TssTicketSystemOverrideStatus
parent: Ticket Systems
grand_parent: Commands
---
# Get-TssTicketSystemOverrideStatus

## SYNOPSIS
Get the approval status of a ticket number override request

## SYNTAX

```
Get-TssTicketSystemOverrideStatus [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns whether a ticket number override request the current user made is approved.
A lighter call than Get-TssTicketSystemOverride, for polling a request.
IsApproved is empty while the request is pending, True once approved and False once denied.
Only the requester can read the status: Secret Server answers Access denied for anyone else and when the request does not exist.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssTicketSystemOverrideStatus -TssSession $session -Id 12
```

Check whether override request 12 is approved

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
Ticket number override request ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TicketSystemOverrideId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.TicketSystems.OverrideStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverrideStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverrideStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverrideStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverrideStatus.ps1)
