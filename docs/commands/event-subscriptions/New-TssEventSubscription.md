---
title: New-TssEventSubscription
parent: Event Subscriptions
grand_parent: Commands
---
# New-TssEventSubscription

## SYNOPSIS
Create a new event subscription

## SYNTAX

```
New-TssEventSubscription [-TssSession] <Session> -Name <String> -EntityAction <Object[]> [-Active] [-SendEmail]
 [-SendSlack] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new event subscription that sends an inbox notification when one of its entity actions happens.
Each entity action pairs an entity type with one of its actions, as returned by Search-TssEventType.
The calling user is added as a subscriber.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$action = @{ EventEntityType = 'User'; EventEntityTypeDisplayName = 'User'; EventActionId = 1; EventActionDisplayName = 'Create' }
New-TssEventSubscription -TssSession $session -Name 'User created' -EntityAction $action -Active
```

Create an active event subscription that notifies the caller whenever a user is created

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

### -Name
Name of the event subscription

```yaml
Type: String
Parameter Sets: (All)
Aliases: SubscriptionName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntityAction
One or more entity actions, as hashtables or objects with these properties: EventEntityType (Entity from Search-TssEventType, for example User or Secret), EventActionId (eventActionId of one of that type's Actions), EventEntityTypeDisplayName and EventActionDisplayName (both required by the server).
Optional: ItemId, ItemName, ContainerId, IncludeSubcontainers, ConditionType.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate the event subscription on creation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendEmail
Send an email when the event happens (requires an SMTP host)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendSlack
Send a Slack message when the event happens (requires the Slack integration)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.EventSubscriptions.EventSubscription
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/New-TssEventSubscription](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/New-TssEventSubscription)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/New-TssEventSubscription.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/New-TssEventSubscription.ps1)
