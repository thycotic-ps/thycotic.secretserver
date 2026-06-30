---
title: Get-TssGroupUser
parent: Groups
grand_parent: Commands
---
# Get-TssGroupUser

## SYNOPSIS
Get a specific user's membership in a Group

## SYNTAX

```
Get-TssGroupUser [-TssSession] <Session> -Id <Int32> -UserId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get the details of a single, specific user within a Group.
Both the Group ID (-Id) and the User ID (-UserId) are required; this command verifies and returns one user's membership in the given Group.

To list ALL users that are members of a Group, use [Get-TssGroupMember](Get-TssGroupMember) instead.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupUser -TssSession $session -Id 8 -UserId 43
```

Get User Id 43 details in Group ID 8

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupMember -TssSession $session -Id 8
```

To list every member of a Group, use Get-TssGroupMember (not Get-TssGroupUser, which targets a single user)

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
Type: Int32
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserId
User ID of the specific user to look up within the Group.
Mandatory; to list all members of a Group use Get-TssGroupMember.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Groups.User
## NOTES
Requires TssSession object returned by New-TssSession

This command targets a single user via the groups/{id}/users/{userId} endpoint, so -UserId is mandatory.
To enumerate all members of a Group use Get-TssGroupMember.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupUser.ps1)

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupMember)