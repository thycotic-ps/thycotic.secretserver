---
title: Remove-TssInboxRuleSubscribe
parent: Inbox Rules
grand_parent: Commands
---
# Remove-TssInboxRuleSubscribe

## SYNOPSIS
Unsubscribe the current user from inbox rules

## SYNTAX

```
Remove-TssInboxRuleSubscribe [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the calling user's own subscription to one or more inbox rules, so the user stops receiving the notifications those rules send.
It only changes the subscription of the user the session belongs to.
Use Search-TssInboxRuleSubscriber to see who else is subscribed.
A user who receives a rule through a subscribed group gets an explicit unsubscribed entry for that rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssInboxRuleSubscribe -TssSession $session -Id 12
```

Unsubscribe the current user from inbox rule 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssInboxRuleSubscribe -TssSession $session -Id 12, 14 -WhatIf
```

Show which inbox rules would be unsubscribed without changing anything

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
Inbox rule ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: InboxRuleId, RuleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Remove-TssInboxRuleSubscribe](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Remove-TssInboxRuleSubscribe)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Remove-TssInboxRuleSubscribe.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Remove-TssInboxRuleSubscribe.ps1)
