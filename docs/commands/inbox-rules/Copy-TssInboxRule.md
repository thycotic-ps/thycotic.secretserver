---
title: Copy-TssInboxRule
parent: Inbox Rules
grand_parent: Commands
---
# Copy-TssInboxRule

## SYNOPSIS
Copy an inbox rule

## SYNTAX

```
Copy-TssInboxRule [-TssSession] <Session> -Id <Int32> -Name <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Copy an inbox rule, with its message types, conditions and actions, to a new rule with the given name.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Copy-TssInboxRule -TssSession $session -Id 1 -Name 'Password Reset (copy)'
```

Copy inbox rule 1 to a new rule named Password Reset (copy)

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
ID of the inbox rule to copy

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
Name of the new inbox rule

```yaml
Type: String
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Copy-TssInboxRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Copy-TssInboxRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Copy-TssInboxRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Copy-TssInboxRule.ps1)
