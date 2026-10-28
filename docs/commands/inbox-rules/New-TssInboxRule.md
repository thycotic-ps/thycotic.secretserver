---
title: New-TssInboxRule
parent: Inbox Rules
grand_parent: Commands
---
# New-TssInboxRule

## SYNOPSIS
Create a new inbox rule

## SYNTAX

```
New-TssInboxRule [-TssSession] <Session> -Name <String> -InboxMessageTypeId <Int32[]> [-Active] [-IsImmediate]
 [-HighPriority] [-CanEditOwnSubscription] [-SendEmail] [-InboxEmailTemplateId <Int32>] [-SendSlack]
 [-InboxSlackTemplateId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new inbox (notification) rule for one or more inbox message types.
The rule needs at least one action: -SendEmail (with an email template) or -SendSlack (with a Slack template).
Add conditions afterwards with New-TssInboxRuleCondition.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxRule -TssSession $session -Name 'Password reset alerts' -InboxMessageTypeId 4 -Active -IsImmediate -CanEditOwnSubscription -SendEmail -InboxEmailTemplateId 5
```

Create an active rule that emails each Password Reset message as it happens

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
Name of the inbox rule

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InboxMessageTypeId
Inbox message types the rule applies to (InboxMessageTypeId from Search-TssInboxMessageType)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate the inbox rule on creation

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

### -IsImmediate
Send notifications as they happen instead of as a scheduled digest

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

### -HighPriority
Mark the rule's notifications as high priority

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

### -CanEditOwnSubscription
Let subscribers subscribe and unsubscribe themselves

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
Send an email for each notification

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

### -InboxEmailTemplateId
Inbox template used for the email

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

### -SendSlack
Send a Slack message for each notification

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

### -InboxSlackTemplateId
Inbox template used for the Slack message

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

### Thycotic.PowerShell.InboxRules.InboxRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRule.ps1)
