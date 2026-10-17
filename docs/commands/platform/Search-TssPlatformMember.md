---
title: Search-TssPlatformMember
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformMember

## SYNOPSIS
Search the Delinea Platform for the members of a directory group

## SYNTAX

```
Search-TssPlatformMember [-TssSession] <Session> [-GroupName <String>] -DomainIdentifier <String>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the members of a Delinea Platform directory group, using the Platform credentials of the integration.
When the Platform reports a problem the message is written as a warning.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$group = Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins'
Search-TssPlatformMember -TssSession $session -GroupName $group.Name -DomainIdentifier $group.DsGuid
```

Returns the display name of each member of the Vault Admins group

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins' | Search-TssPlatformMember -TssSession $session
```

Returns the members of the group found by the search

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

### -GroupName
Name of the group.
Optional: the server finds the group by -DomainIdentifier

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DomainIdentifier
Unique directory identifier of the group, the DsGuid that Search-TssPlatformGroup returns.
Required by the server

```yaml
Type: String
Parameter Sets: (All)
Aliases: DsGuid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DirectoryServices.GroupMember[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformMember)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformMember.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformMember.ps1)
