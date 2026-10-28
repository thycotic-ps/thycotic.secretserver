---
title: Get-TssDiscoveryDependencyRule
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryDependencyRule

## SYNOPSIS
Get a Discovery dependency rule

## SYNTAX

```
Get-TssDiscoveryDependencyRule [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more Discovery dependency rules by id: scan template, dependency template, privileged account and restart setting.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryDependencyRule -TssSession $session -Id 2
```

Get Discovery dependency rule 2

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
Discovery dependency rule id

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.DependencyRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDependencyRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDependencyRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDependencyRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDependencyRule.ps1)
