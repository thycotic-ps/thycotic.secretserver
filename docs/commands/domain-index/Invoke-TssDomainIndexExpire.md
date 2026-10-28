---
title: Invoke-TssDomainIndexExpire
parent: Domain Index
grand_parent: Commands
---
# Invoke-TssDomainIndexExpire

## SYNOPSIS
Expire domain name index entries so Discovery re-indexes them

## SYNTAX

### id (Default)
```
Invoke-TssDomainIndexExpire [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### all
```
Invoke-TssDomainIndexExpire [-TssSession] <Session> [-All] [-ReIndexNow]
 [<CommonParameters>]
```

## DESCRIPTION
Expire domain name index entries.
With -All every entry expires (add -ReIndexNow to re-index the expired entries right away) and the cmdlet returns True.
With -Id each entry expires and is re-indexed, and the cmdlet returns the updated entry.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDomainIndexExpire -TssSession $session -All -ReIndexNow
```

Expire and re-index the whole domain name index

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomainIndex -TssSession $session -DomainResolveType CouldNotResolve | Invoke-TssDomainIndexExpire -TssSession $session
```

Re-index every entry Discovery could not resolve

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

### -Id
Domain name index entry ID to expire and re-index

```yaml
Type: Int32[]
Parameter Sets: id
Aliases: DomainNameIndexId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -All
Expire every entry in the domain name index

```yaml
Type: SwitchParameter
Parameter Sets: all
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReIndexNow
With -All, re-index the expired entries right away instead of on the next Discovery run

```yaml
Type: SwitchParameter
Parameter Sets: all
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DomainIndex.DomainNameIndex
### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Invoke-TssDomainIndexExpire](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Invoke-TssDomainIndexExpire)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Invoke-TssDomainIndexExpire.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Invoke-TssDomainIndexExpire.ps1)
