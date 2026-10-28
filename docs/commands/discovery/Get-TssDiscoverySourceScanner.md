---
title: Get-TssDiscoverySourceScanner
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySourceScanner

## SYNOPSIS
Get a scanner of a discovery source

## SYNTAX

```
Get-TssDiscoverySourceScanner [-TssSession] <Session> -DiscoverySourceId <Int32>
 -DiscoveryItemScannerId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Gets a scanner attached to a discovery source, with its input and output templates, credentials and settings.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySourceScanner -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 12
```

Get scanner 12 of discovery source 3

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

### -DiscoverySourceId
Discovery source ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DiscoveryItemScannerId
Scanner ID on the discovery source

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.SourceScanner
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceScanner.ps1)
