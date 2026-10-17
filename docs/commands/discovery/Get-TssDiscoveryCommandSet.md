---
title: Get-TssDiscoveryCommandSet
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryCommandSet

## SYNOPSIS
Get a Discovery command set

## SYNTAX

```
Get-TssDiscoveryCommandSet [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one or more Discovery command sets by id, including the commands they run.
An id with no matching command set writes an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryCommandSet -TssSession $session -Id 5
```

Get Discovery command set 5

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
Discovery command set id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: CommandSetId, DiscoveryCommandSetId

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

### Thycotic.PowerShell.Discovery.CommandSet
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryCommandSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryCommandSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryCommandSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryCommandSet.ps1)
