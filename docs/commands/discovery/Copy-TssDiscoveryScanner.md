---
title: Copy-TssDiscoveryScanner
parent: Discovery
grand_parent: Commands
---
# Copy-TssDiscoveryScanner

## SYNOPSIS
Copy a Discovery scanner

## SYNTAX

```
Copy-TssDiscoveryScanner [-TssSession] <Session> -ItemScannerId <Int32> -NewItemScannerName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Duplicates an existing Discovery scanner under a new name and returns the new scanner.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Copy-TssDiscoveryScanner -TssSession $session -ItemScannerId 12 -NewItemScannerName 'Windows local accounts (custom)'
```

Copy scanner 12 to a new scanner named Windows local accounts (custom)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanner -TssSession $session -DiscoveryItemScannerId 12 | Copy-TssDiscoveryScanner -TssSession $session -NewItemScannerName 'Windows local accounts (copy)'
```

Copy the scanner returned by Search-TssDiscoveryScanner

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

### -ItemScannerId
Id of the scanner to copy

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DiscoveryItemScannerId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewItemScannerName
Name for the new scanner

```yaml
Type: String
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

### Thycotic.PowerShell.Discovery.Scanner
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Copy-TssDiscoveryScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Copy-TssDiscoveryScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Copy-TssDiscoveryScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Copy-TssDiscoveryScanner.ps1)
