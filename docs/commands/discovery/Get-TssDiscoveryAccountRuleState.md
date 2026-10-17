---
title: Get-TssDiscoveryAccountRuleState
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryAccountRuleState

## SYNOPSIS
Get the global state Discovery account rules depend on

## SYNTAX

```
Get-TssDiscoveryAccountRuleState [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns whether email is configured (needed for account alerts) and whether Remote Password Changing is enabled (needed to change passwords of imported accounts).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryAccountRuleState -TssSession $session
```

Check whether account alerts and password changing are available to Discovery account rules

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

### Thycotic.PowerShell.Discovery.AccountRuleState
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryAccountRuleState](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryAccountRuleState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryAccountRuleState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryAccountRuleState.ps1)
