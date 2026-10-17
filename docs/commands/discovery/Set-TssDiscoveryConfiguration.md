---
title: Set-TssDiscoveryConfiguration
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryConfiguration

## SYNOPSIS
Set the Discovery configuration

## SYNTAX

```
Set-TssDiscoveryConfiguration [-TssSession] <Session> [-DependencyNotFoundThreshold <Int32>]
 [-DiscoveryIntervalDays <Int32>] [-DiscoveryIntervalHours <Int32>] [-DiscoveryScanOffsetHours <Int32>]
 [-EnableDiscovery] [-EngineADDiscoveryBatchSize <Int32>] [-IgnoreClusterNodeObjects] [-MaxLogAgeDays <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates only the settings passed; omitted settings stay unchanged.
Returns the updated configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryConfiguration -TssSession $session -DiscoveryIntervalDays 1 -DiscoveryIntervalHours 0
```

Run Discovery once a day

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryConfiguration -TssSession $session -EnableDiscovery:$false
```

Disable Discovery

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

### -DependencyNotFoundThreshold
Number of scans a dependency can be missing before it is removed

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

### -DiscoveryIntervalDays
Days between Discovery runs

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

### -DiscoveryIntervalHours
Hours between Discovery runs, added to DiscoveryIntervalDays

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

### -DiscoveryScanOffsetHours
Hour offset for the Discovery scan schedule

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

### -EnableDiscovery
Enable Discovery

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

### -EngineADDiscoveryBatchSize
Number of AD objects a distributed engine processes per batch

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

### -IgnoreClusterNodeObjects
Ignore cluster node objects during Discovery

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

### -MaxLogAgeDays
Days to keep Discovery logs

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

### Thycotic.PowerShell.Discovery.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryConfiguration.ps1)
