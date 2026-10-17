---
title: Set-TssDiscoveryDependencyRuleOrder
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryDependencyRuleOrder

## SYNOPSIS
Set the order of the Discovery dependency rules

## SYNTAX

```
Set-TssDiscoveryDependencyRuleOrder [-TssSession] <Session> -DiscoveryRuleDependencyIds <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the order in which Discovery applies its dependency rules.
Pass every rule id in the new order.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryDependencyRuleOrder -TssSession $session -DiscoveryRuleDependencyIds 3, 1, 2
```

Apply dependency rule 3 first, then 1, then 2

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

### -DiscoveryRuleDependencyIds
Dependency rule ids in the new order.
The server does not check that the ids exist

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: RuleId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRuleOrder](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRuleOrder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRuleOrder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRuleOrder.ps1)
