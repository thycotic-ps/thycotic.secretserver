---
title: Get-TssDiscoveryAccountRuleMatch
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryAccountRuleMatch

## SYNOPSIS
Get computer accounts that match a Discovery account rule

## SYNTAX

```
Get-TssDiscoveryAccountRuleMatch [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the discovered computer accounts that the Discovery account rule matches, with the computer, organizational unit and any secret already linked.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryAccountRuleMatch -TssSession $session -Id 3
```

Get the computer accounts matched by Discovery account rule 3

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
Aliases: AccountRuleId, RuleId

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

### Thycotic.PowerShell.Discovery.AccountRuleMatch[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryAccountRuleMatch](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryAccountRuleMatch)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryAccountRuleMatch.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryAccountRuleMatch.ps1)
