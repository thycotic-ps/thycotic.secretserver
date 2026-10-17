---
title: Set-TssEventSubscription
parent: Event Subscriptions
grand_parent: Commands
---
# Set-TssEventSubscription

## SYNOPSIS
Update an event subscription

## SYNTAX

```
Set-TssEventSubscription [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Active]
 [-InboxExpiration <Int32>] [-EntityAction <Object[]>] [-SubscriberGroupId <Int32[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update an event subscription.
Only the parameters provided are changed.
EntityAction and SubscriberGroupId replace the whole list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssEventSubscription -TssSession $session -Id 4 -Name 'User created (audit)' -InboxExpiration 30
```

Rename event subscription 4 and keep its notifications for 30 days

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssEventSubscription -TssSession $session -Id 4 -Active:$false
```

Deactivate event subscription 4

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
Event subscription ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: EventSubscriptionId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New name of the event subscription

```yaml
Type: String
Parameter Sets: (All)
Aliases: SubscriptionName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate (-Active) or deactivate (-Active:$false) the event subscription

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

### -InboxExpiration
Number of days a notification stays in the inbox

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntityAction
Replacement list of entity actions, as hashtables or objects with these properties: EventEntityType, EventActionId, EventEntityTypeDisplayName, EventActionDisplayName, and optional ItemId, ItemName, ContainerId, IncludeSubcontainers, ConditionType (same shape as New-TssEventSubscription)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriberGroupId
Replacement list of subscriber group IDs (a user subscribes through their personal group)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Set-TssEventSubscription](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Set-TssEventSubscription)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Set-TssEventSubscription.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Set-TssEventSubscription.ps1)
