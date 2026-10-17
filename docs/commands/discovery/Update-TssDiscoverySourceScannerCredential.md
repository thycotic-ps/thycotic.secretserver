---
title: Update-TssDiscoverySourceScannerCredential
parent: Discovery
grand_parent: Commands
---
# Update-TssDiscoverySourceScannerCredential

## SYNOPSIS
Replace the credentials of a discovery source scanner

## SYNTAX

### credential (Default)
```
Update-TssDiscoverySourceScannerCredential [-TssSession] <Session> -DiscoverySourceId <Int32>
 -DiscoveryItemScannerId <Int32> [-SecretId <Int32[]>] [-SecretSearchFilterId <Int32[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### clear
```
Update-TssDiscoverySourceScannerCredential [-TssSession] <Session> -DiscoverySourceId <Int32>
 -DiscoveryItemScannerId <Int32> [-Clear] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the credentials a scanner on a discovery source uses to log in to the items it scans.
Each -SecretId and each -SecretSearchFilterId becomes one credential, secrets first, in the order given.
Credentials not given are removed; -Clear removes them all.
Secret Server rejects an empty list when the discovery source has no secret of its own, unless the scanner is a file load or manual input scanner.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -SecretId 31, 32
```

Make scanner 9 of discovery source 3 log in with secret 31, then secret 32

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -SecretSearchFilterId 4
```

Make scanner 9 of discovery source 3 log in with the secret found by secret search filter 4

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 14 -Clear
```

Remove every credential of scanner 14 of discovery source 3

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

### -DiscoverySourceId
Discovery source ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DiscoveryItemScannerId
Scanner ID on the discovery source

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretId
IDs of the secrets to use as credentials

```yaml
Type: Int32[]
Parameter Sets: credential
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretSearchFilterId
IDs of the secret search filters that find the secret to use as a credential (Search-TssDiscoverySecretSearchFilter)

```yaml
Type: Int32[]
Parameter Sets: credential
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear
Remove every credential of the scanner

```yaml
Type: SwitchParameter
Parameter Sets: clear
Aliases:

Required: True
Position: Named
Default value: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerCredential](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerCredential)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerCredential.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerCredential.ps1)
