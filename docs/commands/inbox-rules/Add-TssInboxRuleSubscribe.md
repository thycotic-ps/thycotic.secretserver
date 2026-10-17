---
title: Add-TssInboxRuleSubscribe
parent: Inbox Rules
grand_parent: Commands
---
# Add-TssInboxRuleSubscribe

## SYNOPSIS
Subscribe the current user to an inbox rule

## SYNTAX

```
Add-TssInboxRuleSubscribe [-TssSession] <Session> -Id <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Subscribe the current user to an inbox rule, so the rule's notifications reach them.
Subscribing twice is harmless.
Returns True when the server reports success.
Use Set-TssInboxRuleSubscriber to subscribe other users, groups or email addresses.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssInboxRuleSubscribe -TssSession $session -Id 7
```

Subscribe the current user to inbox rule 7

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
Type: Int32
Parameter Sets: (All)
Aliases: InboxRuleId, RuleId

Required: True
Position: Named
Default value: 0
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Add-TssInboxRuleSubscribe](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Add-TssInboxRuleSubscribe)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Add-TssInboxRuleSubscribe.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Add-TssInboxRuleSubscribe.ps1)
