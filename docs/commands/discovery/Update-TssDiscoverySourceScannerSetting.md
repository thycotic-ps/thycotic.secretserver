---
title: Update-TssDiscoverySourceScannerSetting
parent: Discovery
grand_parent: Commands
---
# Update-TssDiscoverySourceScannerSetting

## SYNOPSIS
Replace the settings of a discovery source scanner

## SYNTAX

```
Update-TssDiscoverySourceScannerSetting [-TssSession] <Session> -DiscoverySourceId <Int32>
 -DiscoveryItemScannerId <Int32> -Setting <Hashtable> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the settings of a scanner on a discovery source.
Settings not given return to their default value, so pass every setting you want to keep.
The setting names are the Name values in the ScannerItems of Get-TssDiscoverySourceScanner.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDiscoverySourceScannerSetting -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -Setting @{ Ports = '22,2222'; DoAuthentication = 'False' }
```

Scan ports 22 and 2222 without logging in to the machines found by scanner 9 of discovery source 3

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

### -Setting
Setting names and values, for example @{ Ports = '22,2222'; DoAuthentication = 'False' }.
Each value is sent as a string

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.SourceScannerSettingResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerSetting.ps1)
