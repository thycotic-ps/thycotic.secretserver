---
title: Set-TssDiscoverySourceScannerOrder
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoverySourceScannerOrder

## SYNOPSIS
Set the run order of the scanners of a discovery source

## SYNTAX

```
Set-TssDiscoverySourceScannerOrder [-TssSession] <Session> -Id <Int32> -DiscoveryItemScannerId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the order in which the scanners of a discovery source run.
Pass the scanner IDs of the source in the order they should run.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoverySourceScannerOrder -TssSession $session -Id 3 -DiscoveryItemScannerId 12, 15, 9
```

Run scanner 12, then 15, then 9 on discovery source 3

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
Scanner IDs of the source, in run order

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Discovery.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySourceScannerOrder](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySourceScannerOrder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySourceScannerOrder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySourceScannerOrder.ps1)
