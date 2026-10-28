---
title: Search-TssDomain
parent: Directory Services
grand_parent: Commands
---
# Search-TssDomain

## SYNOPSIS
Search the domains a user can log in with

## SYNTAX

```
Search-TssDomain [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
List the ID and name of the active directory domains, the list Secret Server offers on its login page.
Inactive domains are not returned; Search-TssDirectoryServiceDomain lists every domain with its settings.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDomain -TssSession $session
```

List the domains users can log in with

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

### Thycotic.PowerShell.DirectoryServices.DomainLookup[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDomain.ps1)
