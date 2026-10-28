---
title: Search-TssDiscoveryDependencyType
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryDependencyType

## SYNOPSIS
Search Discovery dependency types

## SYNTAX

```
Search-TssDiscoveryDependencyType [-TssSession] <Session> [-ValidForDependencyChanger]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the dependency types Discovery knows (for example Windows service, scheduled task or IIS application pool), whether the license allows each one, and whether it can be assigned to a dependency template or a custom dependency changer.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryDependencyType -TssSession $session
```

List every dependency type

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryDependencyType -TssSession $session -ValidForDependencyChanger
```

List the dependency types a custom dependency changer can use

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

### -ValidForDependencyChanger
Return only the dependency types that a custom dependency changer can use

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.DependencyType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyType](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyType.ps1)
