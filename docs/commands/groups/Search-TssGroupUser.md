---
title: Search-TssGroupUser
parent: Groups
grand_parent: Commands
---
# Search-TssGroupUser

## SYNOPSIS
Search users for a group, members and non-members

## SYNTAX

```
Search-TssGroupUser [-TssSession] <Session> -Id <Int32[]> [-SearchTerm <String>] [-Assigned]
 [-DomainId <Int32>] [-UserStatus <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches users against a group.
Each result says whether the user is a member of the group (Assigned).
Without Assigned both members and non-members are returned.
Get-TssGroupMember returns members only.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssGroupUser -TssSession $session -Id 42 -SearchTerm smith
```

Finds users with smith in their display name and shows whether each is a member of group 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssGroupUser -TssSession $session -Id 42 -Assigned:$false -UserStatus Enabled
```

Lists enabled users that are not members of group 42

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
Group ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SearchTerm
Only users whose display name contains this text

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

### -Assigned
Only members of the group.
Use -Assigned:$false for users that are not members; omit it for both

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

### -DomainId
Only users in this directory domain.
Use -1 for local users

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

### -UserStatus
Only users with this status.
All users when omitted

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

### Thycotic.PowerShell.Groups.MemberSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Search-TssGroupUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Search-TssGroupUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Search-TssGroupUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Search-TssGroupUser.ps1)
