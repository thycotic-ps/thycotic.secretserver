---
title: Search-TssDiscoveryAccountRule
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryAccountRule

## SYNOPSIS
Search Discovery account rules

## SYNTAX

```
Search-TssDiscoveryAccountRule [-TssSession] <Session> [-DiscoverySourceId <Int32>] [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns Discovery account rules in their evaluation order.
Active rules only unless Status is set.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryAccountRule -TssSession $session
```

Get the active Discovery account rules

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryAccountRule -TssSession $session -Status All -DiscoverySourceId 2
```

Get every Discovery account rule for discovery source 2, active or not

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

### -DiscoverySourceId
Only include rules that apply to this discovery source

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

### -Status
Rule status to include: All, Active or Inactive

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.AccountRuleSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryAccountRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryAccountRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryAccountRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryAccountRule.ps1)
