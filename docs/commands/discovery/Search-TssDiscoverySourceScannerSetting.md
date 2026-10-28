---
title: Search-TssDiscoverySourceScannerSetting
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoverySourceScannerSetting

## SYNOPSIS
Get the scanners configured on a discovery source

## SYNTAX

```
Search-TssDiscoverySourceScannerSetting [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Lists the scanners configured on a discovery source in run order, with the scan type, input and output templates, and any validation errors.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoverySourceScannerSetting -TssSession $session -Id 3 | Where-Object Errors
```

List the scanners of discovery source 3 that have validation errors

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

### Thycotic.PowerShell.Discovery.SourceScannerSettingSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySourceScannerSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySourceScannerSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySourceScannerSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySourceScannerSetting.ps1)
