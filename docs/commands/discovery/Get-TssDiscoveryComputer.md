---
title: Get-TssDiscoveryComputer
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryComputer

## SYNOPSIS
Get a discovered computer

## SYNTAX

### Default (Default)
```
Get-TssDiscoveryComputer [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Services
```
Get-TssDiscoveryComputer [-TssSession] <Session> -Id <Int32[]> [-Services]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more discovered computers by id, including their accounts.
With Services, returns the service accounts discovered on the computer instead.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryComputer -TssSession $session -Id 42
```

Get the detail of discovered computer 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryComputer -TssSession $session -Id 42 -Services
```

Get the service accounts discovered on computer 42

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
Discovered computer id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ComputerId, NetworkItemId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Services
Return the service accounts discovered on the computer

```yaml
Type: SwitchParameter
Parameter Sets: Services
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.Computer
### Thycotic.PowerShell.Discovery.ComputerServiceAccount[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputer](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputer)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputer.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputer.ps1)
