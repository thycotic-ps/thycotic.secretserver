---
title: Get-TssInboxRule
parent: Inbox Rules
grand_parent: Commands
---
# Get-TssInboxRule

## SYNOPSIS
Get an inbox rule

## SYNTAX

```
Get-TssInboxRule [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get an inbox (notification) rule by ID, with its message types, conditions and email and Slack actions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxRule -TssSession $session -Id 1
```

Return inbox rule 1 (Password Reset on a new install)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxRule -TssSession $session | Get-TssInboxRule -TssSession $session
```

Return the full details of every active inbox rule

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.InboxRules.InboxRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRule.ps1)
