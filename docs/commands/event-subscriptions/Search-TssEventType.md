---
title: Search-TssEventType
parent: Event Subscriptions
grand_parent: Commands
---
# Search-TssEventType

## SYNOPSIS
Search the event types available to event subscriptions

## SYNTAX

```
Search-TssEventType [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Search the entity types an event subscription can watch, each with its actions (eventActionId) and condition types.
Use the Entity and an action's eventActionId to build the EntityAction parameter of New-TssEventSubscription and Set-TssEventSubscription.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventType -TssSession $session | Where-Object Entity -eq 'User' | Select-Object -ExpandProperty Actions
```

Return the actions an event subscription can watch on users

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

### Thycotic.PowerShell.EventSubscriptions.EventType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Search-TssEventType](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Search-TssEventType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Search-TssEventType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Search-TssEventType.ps1)
