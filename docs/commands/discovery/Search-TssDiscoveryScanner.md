---
title: Search-TssDiscoveryScanner
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryScanner

## SYNOPSIS
Search Discovery scanners

## SYNTAX

```
Search-TssDiscoveryScanner [-TssSession] <Session> [-DiscoveryItemScannerId <Int32>] [-ScanTypeId <Int32>]
 [-SearchText <String>] [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Discovery scanners (for example AD user account or local Windows account scanners) that can be added to a discovery source.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanner -TssSession $session
```

List the active scanners

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanner -TssSession $session -ScanTypeId 3 -Status All
```

List every scanner that finds local accounts

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

### -DiscoveryItemScannerId
Return only this scanner.
Replaces -ScanTypeId; -Status and -SearchText still apply, so an inactive scanner needs -Status Inactive or All

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanTypeId
Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies.
Ignored when -DiscoveryItemScannerId is set

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to match, case-insensitive, anywhere in the scanner display name (the name shown in the UI, not DiscoveryItemScannerName)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Active, Inactive or All.
The server returns active scanners when omitted

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Discovery.ScannerSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanner.ps1)
