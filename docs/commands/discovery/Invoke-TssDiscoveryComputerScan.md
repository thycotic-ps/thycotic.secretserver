---
title: Invoke-TssDiscoveryComputerScan
parent: Discovery
grand_parent: Commands
---
# Invoke-TssDiscoveryComputerScan

## SYNOPSIS
Scan discovered computers now

## SYNTAX

```
Invoke-TssDiscoveryComputerScan [-TssSession] <Session> -ComputerId <Int32[]> [-ScanType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a Discovery scan of one or more discovered computers without waiting for the next Discovery run.
Returns one result per computer with the status of each scan type started.
Each computer is scanned in its own request: when several computers are sent together the server stops at the first one it cannot scan (unknown id, Entra ID source or no scanners) and skips the rest.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDiscoveryComputerScan -TssSession $session -ComputerId 42
```

Scan discovered computer 42 for every account type

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDiscoveryComputerScan -TssSession $session -ComputerId 42, 43 -ScanType LocalAccount
```

Scan discovered computers 42 and 43 for local accounts only

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
Discovered computer id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id, NetworkItemId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScanType
Scan type: All (default), LocalAccount, DependencyAccount or EntraRole

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
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

### Thycotic.PowerShell.Discovery.ComputerScanResult[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Invoke-TssDiscoveryComputerScan](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Invoke-TssDiscoveryComputerScan)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Invoke-TssDiscoveryComputerScan.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Invoke-TssDiscoveryComputerScan.ps1)
