---
title: Get-TssEventSubscriptionStub
parent: Event Subscriptions
grand_parent: Commands
---
# Get-TssEventSubscriptionStub

## SYNOPSIS
Get the default values for a new event subscription

## SYNTAX

```
Get-TssEventSubscriptionStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the default values Secret Server uses for a new event subscription: whether email and Slack notifications are on.
The server marks a channel read-only when it is not configured (no SMTP host, no Slack integration).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventSubscriptionStub -TssSession $session
```

Return the default SendEmail and SendSlack values for a new event subscription

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

### Thycotic.PowerShell.EventSubscriptions.Stub
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscriptionStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscriptionStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscriptionStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscriptionStub.ps1)
