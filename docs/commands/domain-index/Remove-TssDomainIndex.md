---
title: Remove-TssDomainIndex
parent: Domain Index
grand_parent: Commands
---
# Remove-TssDomainIndex

## SYNOPSIS
Delete a domain name index entry

## SYNTAX

```
Remove-TssDomainIndex [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete one or more entries from the Discovery domain name index.
Returns True per entry; the server also returns True for an ID that does not exist.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssDomainIndex -TssSession $session -Id 12
```

Delete entry 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomainIndex -TssSession $session -DomainName old.example.com | Remove-TssDomainIndex -TssSession $session
```

Delete the entries for a retired domain

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
Type: Int32[]
Parameter Sets: (All)
Aliases: DomainNameIndexId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Remove-TssDomainIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Remove-TssDomainIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Remove-TssDomainIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Remove-TssDomainIndex.ps1)
