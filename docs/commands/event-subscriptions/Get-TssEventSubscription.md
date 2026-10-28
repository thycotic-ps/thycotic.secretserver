---
title: Get-TssEventSubscription
parent: Event Subscriptions
grand_parent: Commands
---
# Get-TssEventSubscription

## SYNOPSIS
Get an event subscription

## SYNTAX

```
Get-TssEventSubscription [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get an event subscription by ID, including its entity actions and subscribers.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventSubscription -TssSession $session -Id 4
```

Return event subscription 4 with its entity actions and subscribers

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventSubscription -TssSession $session | Get-TssEventSubscription -TssSession $session
```

Return the full details of every active event subscription

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
Type: Int32[]
Parameter Sets: (All)
Aliases: EventSubscriptionId

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

### Thycotic.PowerShell.EventSubscriptions.EventSubscription
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscription](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscription)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscription.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscription.ps1)
