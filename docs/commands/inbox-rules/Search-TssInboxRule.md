---
title: Search-TssInboxRule
parent: Inbox Rules
grand_parent: Commands
---
# Search-TssInboxRule

## SYNOPSIS
Search inbox rules

## SYNTAX

```
Search-TssInboxRule [-TssSession] <Session> [-IncludeInactive] [-IncludeCurrentUserSubscriptionStatus]
 [-IsImmediate] [-MessageTypeId <Int32>] [-MessageId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Search inbox (notification) rules.
Returns the ID, name, state and notification types of each; use Get-TssInboxRule for the full rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxRule -TssSession $session -IncludeInactive -IncludeCurrentUserSubscriptionStatus
```

Return every inbox rule and whether the current user is subscribed to it

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxRule -TssSession $session -MessageTypeId 4
```

Return the active inbox rules that apply to inbox message type 4

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
Include inactive inbox rules

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

### -IncludeCurrentUserSubscriptionStatus
Set CurrentUserSubscribed on each rule

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
Return only immediate rules (-IsImmediate) or only digest rules (-IsImmediate:$false)

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

### -MessageTypeId
Return only the rules that apply to this inbox message type

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

### -MessageId
Return only the rules that apply to this inbox message

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.InboxRules.InboxRuleItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRule.ps1)
