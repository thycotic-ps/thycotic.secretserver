---
title: Get-TssDiscoverySourceAvailableScanner
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySourceAvailableScanner

## SYNOPSIS
Get the scanners that can be added to a discovery source

## SYNTAX

```
Get-TssDiscoverySourceAvailableScanner [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Lists the scanners that can be added to a discovery source, with the scan type of each and whether it is suggested for the source.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySourceAvailableScanner -TssSession $session -Id 3 | Where-Object IsSuggested
```

List the suggested scanners for discovery source 3

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
Discovery source ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: DiscoverySourceId

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

### Thycotic.PowerShell.Discovery.SourceAvailableScanner[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceAvailableScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceAvailableScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceAvailableScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceAvailableScanner.ps1)
