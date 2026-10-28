---
title: Search-TssInboxRuleSubscriber
parent: Inbox Rules
grand_parent: Commands
---
# Search-TssInboxRuleSubscriber

## SYNOPSIS
Search the subscribers of an inbox rule

## SYNTAX

```
Search-TssInboxRuleSubscriber [-TssSession] <Session> -Id <Int32[]> [-AccountType <String>]
 [-OnlyIncludeUnsubscribableUsers] [-SearchText <String>] [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the users, groups and external email addresses subscribed to an inbox rule, including entries that were unsubscribed.
Filter by account type or subscription status.
-OnlyIncludeUnsubscribableUsers lists the users who receive the rule through a subscribed group instead, and -SearchText narrows that list by name.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxRuleSubscriber -TssSession $session -Id 12
```

List every subscriber of inbox rule 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxRuleSubscriber -TssSession $session -Id 12 -AccountType Groups -Status Subscribed
```

List the groups subscribed to inbox rule 12

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
Aliases: InboxRuleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountType
Only return subscribers of this account type: All, Groups, Users or ExternalEmails

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

### -OnlyIncludeUnsubscribableUsers
Only return users who receive the rule through a subscribed group

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

### -SearchText
Only return users whose name contains this text.
The server applies it only together with -OnlyIncludeUnsubscribableUsers

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

### -Status
Only return subscribers with this subscription status: All, Subscribed or Unsubscribed

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.InboxRules.Subscriber[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRuleSubscriber](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRuleSubscriber)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRuleSubscriber.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRuleSubscriber.ps1)
