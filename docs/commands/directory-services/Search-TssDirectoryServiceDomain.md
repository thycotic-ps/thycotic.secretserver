---
title: Search-TssDirectoryServiceDomain
parent: Directory Services
grand_parent: Commands
---
# Search-TssDirectoryServiceDomain

## SYNOPSIS
Search Directory Services domains

## SYNTAX

### filter (Default)
```
Search-TssDirectoryServiceDomain [-TssSession] <Session> [-DomainName <String>] [-IncludeInactive]
 [-SortBy <String>] [<CommonParameters>]
```

### searchText
```
Search-TssDirectoryServiceDomain [-TssSession] <Session> -SearchText <String> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Search Directory Services domains
-SearchText matches the domain name or the friendly name and adds DistinguishedName and SiteId to the output; it reads the active-directory/domains endpoint because the directory-services endpoint filters on the domain name only.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectoryServiceDomain -TssSession $session -DomainName lab.local
```

Return the domain lab.local information

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectoryServiceDomain -TssSession $session -SearchText corp | Select-Object DomainId, DomainName, FriendlyName, DistinguishedName
```

Find domains whose name or friendly name matches corp and show their distinguished names

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

### -DomainName
Domain Name

```yaml
Type: String
Parameter Sets: filter
Aliases: Domain

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to match in the domain name or friendly name

```yaml
Type: String
Parameter Sets: searchText
Aliases:

Required: True
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

### -SortBy
Sort by specific property, default DomainName

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: DomainName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DirectoryServices.DomainSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server marks the active-directory/domains endpoint used by -SearchText obsolete in favor of the directory-services endpoints; it still answers on current versions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceDomain.ps1)
