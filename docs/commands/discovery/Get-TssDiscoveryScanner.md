---
title: Get-TssDiscoveryScanner
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryScanner

## SYNOPSIS
Get a Discovery scanner

## SYNTAX

```
Get-TssDiscoveryScanner [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one or more Discovery scanners by id, including the base scanner, input and output scan templates, and the script or command set they run.
An id with no matching Discovery scanner writes an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryScanner -TssSession $session -Id 12
```

Get scanner 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanner -TssSession $session -ScanTypeId 3 | Get-TssDiscoveryScanner -TssSession $session
```

Get the detail of every active scanner that finds local accounts

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
Scanner id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ItemScannerId, DiscoveryItemScannerId

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

### Thycotic.PowerShell.Discovery.Scanner
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanner.ps1)
