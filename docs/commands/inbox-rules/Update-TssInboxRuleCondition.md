---
title: Update-TssInboxRuleCondition
parent: Inbox Rules
grand_parent: Commands
---
# Update-TssInboxRuleCondition

## SYNOPSIS
Replace the conditions of an inbox rule

## SYNTAX

```
Update-TssInboxRuleCondition [-TssSession] <Session> -InboxRuleId <Int32> -Condition <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replace the whole condition list of an inbox rule.
Conditions left out of the list are removed from the rule.
Pipe the output of Get-TssInboxRuleCondition, changed as needed, to write the list back.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$conditions = Get-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 | Where-Object ValueString -ne 'Test'
Update-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -Condition $conditions
```

Remove the conditions of inbox rule 7 that compare against Test

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -Condition @{ InboxDataId = 2; InboxRuleOperand = 'Regex'; ValueString = '^Prod' }
```

Replace the conditions of inbox rule 7 with one regular expression condition

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

### -InboxRuleId
Inbox rule ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Condition
The full condition list, as Get-TssInboxRuleCondition output or hashtables with these keys: InboxDataId, InboxRuleOperand (Equals, NotEquals, LessThan, GreaterThan, Regex), one of ValueString, ValueInt, ValueBool, ValueDateTime, optional DisplayValue, and InboxRuleConditionId to keep an existing condition

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Update-TssInboxRuleCondition](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Update-TssInboxRuleCondition)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Update-TssInboxRuleCondition.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Update-TssInboxRuleCondition.ps1)
