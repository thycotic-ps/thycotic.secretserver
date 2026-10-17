---
title: Set-TssGroupMember
parent: Groups
grand_parent: Commands
---
# Set-TssGroupMember

## SYNOPSIS
Add and remove group members in one request

## SYNTAX

```
Set-TssGroupMember [-TssSession] <Session> -Id <Int32> [-AddUserId <Int32[]>] [-RemoveUserId <Int32[]>]
 [-AllowInactiveUsersUpdate] [-ReturnValidationErrors] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds and removes users of a group in a single request.
Only the users you list change; all other members stay.
Update-TssGroupMember replaces the whole member list instead, and Add-TssGroupMember and Remove-TssGroupMember change one user per request.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssGroupMember -TssSession $session -Id 42 -AddUserId 17, 18 -RemoveUserId 99
```

Adds users 17 and 18 to group 42 and removes user 99

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssGroupMember -TssSession $session -Id 42 -RemoveUserId 99 -ReturnValidationErrors
```

Removes user 99 from group 42 and reports users that were not found

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

### -AddUserId
User IDs to add to the group

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveUserId
User IDs to remove from the group

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowInactiveUsersUpdate
Allow inactive users in AddUserId and RemoveUserId

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

### -ReturnValidationErrors
Return validation errors for users that are not found

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

### Thycotic.PowerShell.Groups.MemberChangeStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroupMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroupMember)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroupMember.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroupMember.ps1)
