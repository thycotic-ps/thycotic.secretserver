---
title: Add-TssDiscoverySourceScanner
parent: Discovery
grand_parent: Commands
---
# Add-TssDiscoverySourceScanner

## SYNOPSIS
Add a scanner to a discovery source

## SYNTAX

```
Add-TssDiscoverySourceScanner [-TssSession] <Session> -Id <Int32> -DiscoveryItemScannerId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a scanner to a discovery source and returns the scanner as attached to the source.
A newly added scanner is not valid until its settings and credentials are set with Update-TssDiscoverySourceScannerSetting and Update-TssDiscoverySourceScannerCredential.
Get-TssDiscoverySourceAvailableScanner lists the scanners that can be added.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssDiscoverySourceScanner -TssSession $session -Id 3 -DiscoveryItemScannerId 12
```

Add scanner 12 to discovery source 3

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
Type: Int32
Parameter Sets: (All)
Aliases: DiscoverySourceId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DiscoveryItemScannerId
ID of the scanner to add, from Get-TssDiscoverySourceAvailableScanner

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Discovery.SourceScanner
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Add-TssDiscoverySourceScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Add-TssDiscoverySourceScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Add-TssDiscoverySourceScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Add-TssDiscoverySourceScanner.ps1)
