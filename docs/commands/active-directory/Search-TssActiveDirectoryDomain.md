---
title: Search-TssActiveDirectoryDomain
parent: Active Directory
grand_parent: Commands
---
# Search-TssActiveDirectoryDomain

## SYNOPSIS
Search directory domains through the legacy Active Directory endpoint

## SYNTAX

```
Search-TssActiveDirectoryDomain [-TssSession] <Session> [-SearchText <String>] [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Search the directory domains (Active Directory, Azure AD, OpenLDAP) through the legacy active-directory endpoint.
Unlike Search-TssDirectoryServiceDomain it returns the distinguished name, site and concurrency ID of each domain.
Active domains only unless -IncludeInactive is passed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssActiveDirectoryDomain -TssSession $session -IncludeInactive
```

List every directory domain, active or not

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssActiveDirectoryDomain -TssSession $session -SearchText corp | Select-Object DomainId, DomainName, DistinguishedName
```

Find domains matching corp and show their distinguished names

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

### -SearchText
Text to match in the domain name or friendly name

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

### -IncludeInactive
Include inactive domains

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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

### Thycotic.PowerShell.ActiveDirectory.DomainSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server marks this endpoint obsolete in favor of the directory-services endpoints; it still answers on current versions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Search-TssActiveDirectoryDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Search-TssActiveDirectoryDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Search-TssActiveDirectoryDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Search-TssActiveDirectoryDomain.ps1)
