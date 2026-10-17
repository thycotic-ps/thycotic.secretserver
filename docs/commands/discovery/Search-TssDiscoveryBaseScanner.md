---
title: Search-TssDiscoveryBaseScanner
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryBaseScanner

## SYNOPSIS
Search Discovery base scanners

## SYNTAX

```
Search-TssDiscoveryBaseScanner [-TssSession] <Session> [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Discovery base scanners (Windows, SSH, ESX, AWS and others) and the scan type each supports.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryBaseScanner -TssSession $session -Status Enabled
```

Get the enabled Discovery base scanners

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

### -Status
Only return scanners that are Enabled or Disabled

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

### Thycotic.PowerShell.Discovery.BaseScanner[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryBaseScanner](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryBaseScanner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryBaseScanner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryBaseScanner.ps1)
