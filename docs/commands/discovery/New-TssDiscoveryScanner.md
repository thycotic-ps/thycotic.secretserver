---
title: New-TssDiscoveryScanner
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoveryScanner

## SYNOPSIS
Create a Discovery scanner

## SYNTAX

```
New-TssDiscoveryScanner [-TssSession] <Session> -BaseScannerId <Int32> [-CommandSetId <Int32>]
 [-ConcurrencyId <String>] -InputScanItemTemplateId <Int32> [-IsActive] [-ItemScannerDescription <String>]
 -ItemScannerName <String> -OutputScanItemTemplateId <Int32> -ScanTypeId <Int32> [-ScriptArguments <String>]
 [-ScriptId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Discovery scanner from a base scanner, with its input and output scan templates and, for PowerShell or SSH scanners, the script or command set it runs.
Returns the created scanner.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoveryScanner -TssSession $session -ItemScannerName 'Linux local accounts (custom)' -ScanTypeId 3 -BaseScannerId 5 -InputScanItemTemplateId 2 -OutputScanItemTemplateId 6 -CommandSetId 4 -IsActive
```

Create an active SSH scanner that finds local accounts with command set 4

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

### -BaseScannerId
Base scanner id

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

### -CommandSetId
Command set id, for SSH scanners

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

### -ConcurrencyId
Globally unique id for the scanner.
The server sets one when omitted

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

### -InputScanItemTemplateId
Input scan template id

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

### -IsActive
Create the scanner active.
Without it the scanner is created inactive

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemScannerDescription
Scanner description

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

### -ItemScannerName
Scanner name

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

### -OutputScanItemTemplateId
Output scan template id

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

### -ScanTypeId
Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

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

### -ScriptArguments
Arguments passed to the PowerShell script

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

### -ScriptId
PowerShell script id, for PowerShell scanners

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanner.ps1)
