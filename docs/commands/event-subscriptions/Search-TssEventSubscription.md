---
title: Search-TssEventSubscription
parent: Event Subscriptions
grand_parent: Commands
---
# Search-TssEventSubscription

## SYNOPSIS
Search event subscriptions

## SYNTAX

```
Search-TssEventSubscription [-TssSession] <Session> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Search event subscriptions.
Returns the ID, name and active state of each; use Get-TssEventSubscription for entity actions and subscribers.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventSubscription -TssSession $session -IncludeInactive
```

Return all event subscriptions, active and inactive

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

### -IncludeInactive
Include inactive event subscriptions

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventSubscriptions.EventSubscriptionItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Search-TssEventSubscription](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Search-TssEventSubscription)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Search-TssEventSubscription.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Search-TssEventSubscription.ps1)
