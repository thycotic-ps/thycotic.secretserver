---
title: Get-TssInboxRuleActionLog
parent: Inbox Rules
grand_parent: Commands
---
# Get-TssInboxRuleActionLog

## SYNOPSIS
Get the action log of an inbox rule

## SYNTAX

```
Get-TssInboxRuleActionLog [-TssSession] <Session> -Id <Int32[]> [-EndDate <DateTime>]
 [-RuleActionStatus <String>] [-StartDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Get the action log of an inbox rule: every email or Slack notification the rule sent, with its status.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxRuleActionLog -TssSession $session -Id 1 -RuleActionStatus Failed
```

Return the notifications of inbox rule 1 that failed to send

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

### -EndDate
Return only entries on or before this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RuleActionStatus
Return only entries with this status

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

### -StartDate
Return only entries on or after this date

```yaml
Type: DateTime
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

### Thycotic.PowerShell.InboxRules.ActionLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleActionLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleActionLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleActionLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleActionLog.ps1)
