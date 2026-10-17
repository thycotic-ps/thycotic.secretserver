---
title: New-TssDomainIndex
parent: Domain Index
grand_parent: Commands
---
# New-TssDomainIndex

## SYNOPSIS
Add a domain to the domain name index

## SYNTAX

```
New-TssDomainIndex [-TssSession] <Session> [-DiscoverySourceId <Int32>] [-Ignored] -DomainName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add a domain name to the Discovery domain name index, optionally marked as ignored or with the discovery source it should resolve to.
Returns the new entry.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDomainIndex -TssSession $session -DomainName corp.example.com -DiscoverySourceId 2
```

Map corp.example.com to discovery source 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDomainIndex -TssSession $session -DomainName lab.example.com -Ignored
```

Add lab.example.com as an ignored domain

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
Discovery source the domain should resolve to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DiscoverySourceIdSuggested

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ignored
Mark the domain as ignored by Discovery

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: DomainMarkedAsIgnored

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainName
Domain name to add

```yaml
Type: String
Parameter Sets: (All)
Aliases: DomainNameDiscovered

Required: True
Position: Named
Default value: None
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

### Thycotic.PowerShell.DomainIndex.DomainNameIndex
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/New-TssDomainIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/New-TssDomainIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/New-TssDomainIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/New-TssDomainIndex.ps1)
