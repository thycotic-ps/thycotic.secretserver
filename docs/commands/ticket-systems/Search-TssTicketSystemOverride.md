---
title: Search-TssTicketSystemOverride
parent: Ticket Systems
grand_parent: Commands
---
# Search-TssTicketSystemOverride

## SYNOPSIS
Search ticket number override requests

## SYNTAX

```
Search-TssTicketSystemOverride [-TssSession] <Session> [-RequestType <String>] [-State <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns ticket number override requests: requests to use a ticket number that the ticket system rejected, when the ticket system allows overrides.
By default the requests the current user made; -RequestType ApprovalRequests returns the requests the current user can approve.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystemOverride -TssSession $session -RequestType ApprovalRequests -State Pending
```

List the override requests waiting on the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystemOverride -TssSession $session -State Approved
```

List the approved override requests the current user made

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

### -RequestType
MyRequests (the default) returns the requests the current user made; ApprovalRequests returns the requests the current user can approve

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

### -State
Return only the requests in this state; all states when omitted

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

### Thycotic.PowerShell.TicketSystems.OverrideSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystemOverride](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystemOverride)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystemOverride.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystemOverride.ps1)
