---
title: Search-TssSubscription
parent: Subscriptions
grand_parent: Commands
---
# Search-TssSubscription

## SYNOPSIS
Search the subscriptions of a Secret Server Cloud tenant

## SYNTAX

```
Search-TssSubscription [-TssSession] <Session> [-IncludeUsage]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the subscription line items of a Secret Server Cloud tenant: display name, units, start and end date, recurrence and note.
Use -IncludeUsage to get one object with the current and licensed numbers of users, secrets, sites, engines and session monitoring storage, with the line items in its Subscriptions property.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSubscription -TssSession $session
```

List the subscription line items

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSubscription -TssSession $session -IncludeUsage | Select-Object NumberOfUsers, MaxNumberOfUsers, NumberOfSecrets, MaxNumberOfSecrets
```

Compare user and secret counts with the licensed limits

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

### -IncludeUsage
Return one object with the usage counts and licensed limits, with the line items in its Subscriptions property

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

### Thycotic.PowerShell.Subscriptions.Subscription
### Thycotic.PowerShell.Subscriptions.Usage
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: on-premises Secret Server answers with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/subscriptions/Search-TssSubscription](https://thycotic-ps.github.io/thycotic.secretserver/commands/subscriptions/Search-TssSubscription)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/subscriptions/Search-TssSubscription.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/subscriptions/Search-TssSubscription.ps1)
