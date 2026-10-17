---
title: Search-TssDiscoveryCommandSet
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryCommandSet

## SYNOPSIS
Search Discovery command sets

## SYNTAX

```
Search-TssDiscoveryCommandSet [-TssSession] <Session> [-ScanTypeId <Int32>] [-SearchText <String>]
 [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns Discovery command sets.
Active command sets only unless Status is set.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryCommandSet -TssSession $session -Status All -ScanTypeId 3
```

Get every Discovery command set that finds local accounts

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

### -ScanTypeId
Scan type: 1 = host ranges, 2 = machines, 3 = local accounts, 4 = dependencies

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
Only return command sets whose name contains this text

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
Command set status to include: All, Active or Inactive

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

### Thycotic.PowerShell.Discovery.CommandSetSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryCommandSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryCommandSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryCommandSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryCommandSet.ps1)
