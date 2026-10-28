---
title: Set-TssDiscoveryAccountRuleOrder
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryAccountRuleOrder

## SYNOPSIS
Set the evaluation order of Discovery account rules

## SYNTAX

```
Set-TssDiscoveryAccountRuleOrder [-TssSession] <Session> -RuleId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the order in which Discovery account rules are evaluated.
Pass every rule id in the new order, inactive rules included: Search-TssDiscoveryAccountRule -Status All lists them all.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryAccountRuleOrder -TssSession $session -RuleId 4, 3, 7
```

Evaluate Discovery account rule 4 first, then 3, then 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$ids = @((Search-TssDiscoveryAccountRule -TssSession $session -Status All | Sort-Object SortOrder).RuleId)
[array]::Reverse($ids)
Set-TssDiscoveryAccountRuleOrder -TssSession $session -RuleId $ids
```

Reverse the evaluation order of every Discovery account rule

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

### -RuleId
Discovery account rule ids in the new evaluation order

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Discovery.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRuleOrder](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRuleOrder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRuleOrder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRuleOrder.ps1)
