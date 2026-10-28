---
title: Get-TssDiscoveryComputerScanLog
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryComputerScanLog

## SYNOPSIS
Get Discovery computer scan logs

## SYNTAX

```
Get-TssDiscoveryComputerScanLog [-TssSession] <Session> [-ComputerId <Int32>] [-DiscoveryItemScannerId <Int32>]
 [-DiscoverySourceId <Int32>] [-Result <String>] [-ScanEndDate <DateTime>] [-ScanItemTemplateId <Int32>]
 [-ScanStartDate <DateTime>] [-SearchText <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns Discovery computer scan log entries, filtered by computer, scanner, discovery source, scan template, outcome, date range or log text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryComputerScanLog -TssSession $session -ComputerId 42
```

Get the scan logs of discovered computer 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryComputerScanLog -TssSession $session -Result Error -ScanStartDate (Get-Date).AddDays(-1)
```

Get the failed computer scans of the last day

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

### -ComputerId
Only return logs for this discovered computer id

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

### -DiscoveryItemScannerId
Only return logs for this scanner id

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

### -DiscoverySourceId
Only return logs for this discovery source id

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

### -Result
Only return successful scans (Success) or failed scans (Error).
Omit for both

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

### -ScanEndDate
Only return logs with a scan date on or before this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanItemTemplateId
Only return logs for this scan template id

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

### -ScanStartDate
Only return logs with a scan date on or after this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Only return logs whose message contains this text

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

### Thycotic.PowerShell.Discovery.ComputerScanLog[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputerScanLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputerScanLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputerScanLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputerScanLog.ps1)
