---
title: Get-TssDiscoveryDependencyRuleInfo
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryDependencyRuleInfo

## SYNOPSIS
Get the options for a Discovery dependency rule

## SYNTAX

```
Get-TssDiscoveryDependencyRuleInfo [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the dependency templates, secret templates and password types that a Discovery dependency rule can use for the given scan template, and whether a privileged account secret is required.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryDependencyRuleInfo -TssSession $session -Id 6
```

Get the dependency rule options for scan template 6

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
Discovery scan template id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScanTemplateId

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

### Thycotic.PowerShell.Discovery.DependencyRuleInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDependencyRuleInfo](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDependencyRuleInfo)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDependencyRuleInfo.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDependencyRuleInfo.ps1)
