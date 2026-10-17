---
title: Get-TssDiscoveryComputerAccount
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryComputerAccount

## SYNOPSIS
Get a discovered computer account

## SYNTAX

```
Get-TssDiscoveryComputerAccount [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more discovered computer accounts by id, including the computer, password age and any linked secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryComputerAccount -TssSession $session -Id 118
```

Get discovered computer account 118

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
Discovered computer account id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ComputerAccountId

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

### Thycotic.PowerShell.Discovery.ComputerAccount
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputerAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputerAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputerAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputerAccount.ps1)
