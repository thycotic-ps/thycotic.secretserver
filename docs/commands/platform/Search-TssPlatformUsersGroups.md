---
title: Search-TssPlatformUsersGroups
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformUsersGroups

## SYNOPSIS
Search Delinea Platform users and groups

## SYNTAX

```
Search-TssPlatformUsersGroups [-TssSession] <Session> [-EntityType <String>] [-ExcludeLinkedLocalEntities]
 [-NextLink <String>] [-PlatformDirectoryUuid <String>] [-SearchText <String>] [-ShowLinkedLocalEntities]
 [<CommonParameters>]
```

## DESCRIPTION
Search the Delinea Platform for users or groups, optionally showing or excluding those already linked to Secret Server users and groups.
The Platform returns at most 100 identities per page; this cmdlet follows the next-page link until every page is read.
Returns nothing when Platform integration is not enabled.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformUsersGroups -TssSession $session -SearchText 'Admin' -EntityType Groups -ShowLinkedLocalEntities
```

Find Platform groups starting with Admin and show the Secret Server group each is linked to

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

### -EntityType
Search Users (default) or Groups

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

### -ExcludeLinkedLocalEntities
Leave out identities already linked to a Secret Server user or group

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

### -NextLink
Next-page link to start from instead of the first page

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

### -PlatformDirectoryUuid
Platform directory Id (GUID) to search, from Search-TssPlatformDirectory

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

### -SearchText
Start of the name.
The Platform matches names that start with this text; * is not a wildcard, so 'adm' finds admin but 'adm*' does not

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

### -ShowLinkedLocalEntities
Include the Secret Server user or group Id linked to each identity

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

### Thycotic.PowerShell.Platform.UserGroupSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUsersGroups](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUsersGroups)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUsersGroups.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUsersGroups.ps1)
