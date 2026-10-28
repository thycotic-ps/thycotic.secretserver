---
title: Get-TssDiscoveryStatus
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryStatus

## SYNOPSIS
Get status of Discovery

## SYNTAX

### status (Default)
```
Get-TssDiscoveryStatus [-TssSession] <Session> [<CommonParameters>]
```

### itemMetrics
```
Get-TssDiscoveryStatus [-TssSession] <Session> [-ItemMetrics]
 [<CommonParameters>]
```

### osMetrics
```
Get-TssDiscoveryStatus [-TssSession] <Session> [-OsMetrics]
 [<CommonParameters>]
```

### scanResults
```
Get-TssDiscoveryStatus [-TssSession] <Session> [-ScanResults]
 [<CommonParameters>]
```

## DESCRIPTION
Get status of Discovery
With -ItemMetrics, -OsMetrics or -ScanResults, returns the managed and unmanaged counts per discovered item type, the computer count per operating system, or the success and error counts per discovery source instead.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryStatus -TssSession $session - some test value
```

Add minimum example for each parameter

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryStatus -TssSession $session -ItemMetrics
```

List the managed and unmanaged counts of discovered accounts, keys and other item types

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryStatus -TssSession $session -OsMetrics
```

List how many discovered computers run each operating system

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryStatus -TssSession $session -ScanResults | Where-Object ErrorCount -GT 0
```

List the discovery sources whose last scan had errors

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

### -ItemMetrics
Return the managed and unmanaged counts per discovered item type

```yaml
Type: SwitchParameter
Parameter Sets: itemMetrics
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OsMetrics
Return the number of discovered computers per operating system

```yaml
Type: SwitchParameter
Parameter Sets: osMetrics
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScanResults
Return the success and error counts of the last scan per discovery source

```yaml
Type: SwitchParameter
Parameter Sets: scanResults
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.Status
### Thycotic.PowerShell.Discovery.StatusItemMetric[]
### Thycotic.PowerShell.Discovery.StatusOsMetric[]
### Thycotic.PowerShell.Discovery.StatusScanResult[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryStatus.ps1)