---
title: Get-TssInboxRuleStub
parent: Inbox Rules
grand_parent: Commands
---
# Get-TssInboxRuleStub

## SYNOPSIS
Get the default values for a new inbox rule

## SYNTAX

```
Get-TssInboxRuleStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the default values Secret Server uses for a new inbox rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxRuleStub -TssSession $session
```

Return the default values of a new inbox rule

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.InboxRules.InboxRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleStub.ps1)
