---
title: Get-TssInboxRuleCondition
parent: Inbox Rules
grand_parent: Commands
---
# Get-TssInboxRuleCondition

## SYNOPSIS
Get the conditions of an inbox rule

## SYNTAX

### rule (Default)
```
Get-TssInboxRuleCondition [-TssSession] <Session> -InboxRuleId <Int32[]>
 [<CommonParameters>]
```

### condition
```
Get-TssInboxRuleCondition [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the conditions of an inbox rule (-InboxRuleId), or a single inbox rule condition by its own ID (-Id).
When the server cannot list the conditions of a rule (HTTP 500), the cmdlet reads them from the rule itself.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxRuleCondition -TssSession $session -InboxRuleId 7
```

Return the conditions of inbox rule 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxRuleCondition -TssSession $session -Id 3
```

Return inbox rule condition 3

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
Inbox rule ID: return all of its conditions

```yaml
Type: Int32[]
Parameter Sets: rule
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Inbox rule condition ID: return that condition

```yaml
Type: Int32[]
Parameter Sets: condition
Aliases: InboxRuleConditionId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.InboxRules.Condition
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleCondition](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleCondition)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleCondition.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleCondition.ps1)
