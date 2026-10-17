---
title: New-TssDiscoverySourceScannerSetting
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoverySourceScannerSetting

## SYNOPSIS
Add a scanner to an Active Directory discovery source

## SYNTAX

```
New-TssDiscoverySourceScannerSetting [-TssSession] <Session> -Id <Int32> -DiscoveryScanTypeId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a scanner to an Active Directory discovery source and returns its scanner map ID.
Returns the existing scanner map ID when the source already has the scanner.
Despite its name, Secret Server reads -DiscoveryScanTypeId as a scanner ID (DiscoveryItemScannerId), not a scan type ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$scanner = Get-TssDiscoverySourceAvailableScanner -TssSession $session -Id 3 | Where-Object DiscoveryItemScannerName -eq 'Windows Local Accounts'
New-TssDiscoverySourceScannerSetting -TssSession $session -Id 3 -DiscoveryScanTypeId $scanner.DiscoveryItemScannerId
```

Add the Windows Local Accounts scanner to discovery source 3

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

### -DiscoveryScanTypeId
ID of the scanner to add: the DiscoveryItemScannerId from Get-TssDiscoverySourceAvailableScanner, not its DiscoveryScanTypeId

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

### Thycotic.PowerShell.Discovery.SourceScannerSetting
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySourceScannerSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySourceScannerSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySourceScannerSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySourceScannerSetting.ps1)
