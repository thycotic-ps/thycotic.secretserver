---
title: Remove-TssDiscoveryAccountRule
parent: Discovery
grand_parent: Commands
---
# Remove-TssDiscoveryAccountRule

## SYNOPSIS
Remove a Discovery account rule

## SYNTAX

```
Remove-TssDiscoveryAccountRule [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes one or more Discovery account rules by id.
Secret Server deactivates a removed rule rather than deleting it: it stays listed by Search-TssDiscoveryAccountRule -Status Inactive.
Returns one result per rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssDiscoveryAccountRule -TssSession $session -Id 3
```

Delete Discovery account rule 3

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
Discovery account rule id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: RuleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Remove-TssDiscoveryAccountRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Remove-TssDiscoveryAccountRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Remove-TssDiscoveryAccountRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Remove-TssDiscoveryAccountRule.ps1)
