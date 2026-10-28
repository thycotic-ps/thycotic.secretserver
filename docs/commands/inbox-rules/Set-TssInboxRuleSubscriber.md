---
title: Set-TssInboxRuleSubscriber
parent: Inbox Rules
grand_parent: Commands
---
# Set-TssInboxRuleSubscriber

## SYNOPSIS
Subscribe or unsubscribe users, groups and email addresses to an inbox rule

## SYNTAX

```
Set-TssInboxRuleSubscriber [-TssSession] <Session> -Id <Int32> [-UserId <Int32[]>] [-GroupId <Int32[]>]
 [-EmailAddress <String[]>] [-Unsubscribe] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Subscribe users, groups and external email addresses to an inbox rule in one call, or unsubscribe them with -Unsubscribe.
Subscribers not named are left unchanged.
Use Add-TssInboxRuleSubscribe to subscribe the current user.
Returns True when the server reports success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxRuleSubscriber -TssSession $session -Id 7 -GroupId 5 -EmailAddress 'oncall@example.com'
```

Subscribe group 5 and an external email address to inbox rule 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxRuleSubscriber -TssSession $session -Id 7 -UserId 17 -Unsubscribe
```

Unsubscribe user 17 from inbox rule 7

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

### -UserId
User IDs to subscribe or unsubscribe

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

### -GroupId
Group IDs to subscribe or unsubscribe

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

### -EmailAddress
External email addresses to subscribe or unsubscribe

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unsubscribe
Unsubscribe the named users, groups and email addresses instead of subscribing them

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleSubscriber](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleSubscriber)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleSubscriber.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleSubscriber.ps1)
