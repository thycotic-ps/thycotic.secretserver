---
title: Set-TssDomainIndex
parent: Domain Index
grand_parent: Commands
---
# Set-TssDomainIndex

## SYNOPSIS
Update a domain name index entry

## SYNTAX

```
Set-TssDomainIndex [-TssSession] <Session> -Id <Int32> [-DiscoverySourceId <Int32>] [-Ignored]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Mark a domain name index entry as ignored, or set the discovery source it resolves to.
Only the parameters you pass are sent.
The server expires and re-indexes the entry as part of the update.
Returns the updated entry.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDomainIndex -TssSession $session -Id 12 -DiscoverySourceId 2
```

Map entry 12 to discovery source 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomainIndex -TssSession $session -DomainName lab.example.com | Set-TssDomainIndex -TssSession $session -Ignored
```

Ignore every index entry for lab.example.com

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
Domain name index entry ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DomainNameIndexId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
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
Mark the domain as ignored by Discovery; -Ignored:$false clears it

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Set-TssDomainIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Set-TssDomainIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Set-TssDomainIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Set-TssDomainIndex.ps1)
