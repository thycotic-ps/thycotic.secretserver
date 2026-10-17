---
title: Set-TssInboxRuleAction
parent: Inbox Rules
grand_parent: Commands
---
# Set-TssInboxRuleAction

## SYNOPSIS
Update the actions of an inbox rule

## SYNTAX

```
Set-TssInboxRuleAction [-TssSession] <Session> -Id <Int32> [-SendEmail] [-InboxEmailTemplateId <Int32>]
 [-SendSlack] [-InboxSlackTemplateId <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update the email and Slack actions of an inbox rule and the templates they use.
Only the parameters provided are changed.
The server rejects a change that leaves the rule without an action (400, Not a valid value).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxRuleAction -TssSession $session -Id 7 -SendEmail -InboxEmailTemplateId 5
```

Make inbox rule 7 send an email using inbox template 5

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

### -SendEmail
Send an email for each notification (-SendEmail) or stop sending email (-SendEmail:$false)

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
Send a Slack message for each notification (-SendSlack) or stop (-SendSlack:$false)

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleAction](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleAction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleAction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleAction.ps1)
