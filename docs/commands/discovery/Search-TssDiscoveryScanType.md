---
title: Search-TssDiscoveryScanType
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryScanType

## SYNOPSIS
Search Discovery scan types

## SYNTAX

```
Search-TssDiscoveryScanType [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the Discovery scan types (find host ranges, find machines, find local accounts, find dependencies) with their ids and descriptions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanType -TssSession $session
```

List the Discovery scan types

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.ScanType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanType](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanType.ps1)
