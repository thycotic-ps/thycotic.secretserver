---
title: Search-TssDomainIndex
parent: Domain Index
grand_parent: Commands
---
# Search-TssDomainIndex

## SYNOPSIS
Search the domain name index

## SYNTAX

```
Search-TssDomainIndex [-TssSession] <Session> [-DiscoverySourceIdScanned <Int32>] [-DomainName <String>]
 [-DomainResolveType <String>] [<CommonParameters>]
```

## DESCRIPTION
Search the Discovery domain name index: each entry shows the domain name, how it resolved, the discovery source it maps to, whether it is ignored, and when it was indexed and expires.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomainIndex -TssSession $session -DomainResolveType CouldNotResolve
```

List the domains Discovery could not resolve

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomainIndex -TssSession $session -DomainName example.com
```

Find index entries for example.com

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

### -DiscoverySourceIdScanned
Only entries found by this discovery source

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

### -DomainName
Text to match in the domain name

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

### -DomainResolveType
Only entries resolved this way

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

### Thycotic.PowerShell.DomainIndex.DomainNameIndex[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Search-TssDomainIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Search-TssDomainIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Search-TssDomainIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Search-TssDomainIndex.ps1)
