---
title: Clear-TssDomainIndex
parent: Domain Index
grand_parent: Commands
---
# Clear-TssDomainIndex

## SYNOPSIS
Delete every entry in the domain name index

## SYNTAX

```
Clear-TssDomainIndex [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete every entry in the Discovery domain name index.
Discovery rebuilds the index on its next runs.
Returns True.
The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssDomainIndex -TssSession $session -Confirm:$false
```

Empty the domain name index without a confirmation prompt

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Clear-TssDomainIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Clear-TssDomainIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Clear-TssDomainIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Clear-TssDomainIndex.ps1)
