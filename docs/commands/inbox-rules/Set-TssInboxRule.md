---
title: Set-TssInboxRule
parent: Inbox Rules
grand_parent: Commands
---
# Set-TssInboxRule

## SYNOPSIS
Update an inbox rule

## SYNTAX

```
Set-TssInboxRule [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Active] [-IsImmediate] [-HighPriority]
 [-CanEditOwnSubscription] [-InboxMessageTypeId <Int32[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the name, state, timing and message types of an inbox rule.
Only the parameters provided are changed.
Use Set-TssInboxRuleAction for the email and Slack actions and Update-TssInboxRuleCondition for the conditions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxRule -TssSession $session -Id 7 -Name 'Password reset alerts (ops)' -HighPriority
```

Rename inbox rule 7 and mark its notifications as high priority

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxRule -TssSession $session -Id 7 -Active:$false
```

Deactivate inbox rule 7

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
Aliases: InboxRuleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New name of the inbox rule

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate (-Active) or deactivate (-Active:$false) the inbox rule

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
Send notifications as they happen (-IsImmediate) or as a scheduled digest (-IsImmediate:$false)

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
Mark the rule's notifications as high priority, or not with -HighPriority:$false

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
Let subscribers subscribe and unsubscribe themselves, or not with -CanEditOwnSubscription:$false

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

### -InboxMessageTypeId
Replacement list of inbox message types the rule applies to

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

### Thycotic.PowerShell.InboxRules.InboxRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRule.ps1)
