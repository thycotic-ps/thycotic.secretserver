---
title: Get-TssTicketSystemOverride
parent: Ticket Systems
grand_parent: Commands
---
# Get-TssTicketSystemOverride

## SYNOPSIS
Get a ticket number override request

## SYNTAX

```
Get-TssTicketSystemOverride [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one ticket number override request: ticket number, secret, requester and reason, approver, state and expiration, and whether the current user can approve it.
Secret Server answers Access denied when the request does not exist or is not visible to the current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssTicketSystemOverride -TssSession $session -Id 12
```

Get override request 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystemOverride -TssSession $session -RequestType ApprovalRequests -State Pending | Get-TssTicketSystemOverride -TssSession $session | Where-Object CanApprove
```

Get the pending override requests the current user can approve

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

### Thycotic.PowerShell.TicketSystems.Override
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystemOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystemOverride.ps1)
