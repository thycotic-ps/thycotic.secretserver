---
title: Set-TssUserOwner
parent: Users
grand_parent: Commands
---
# Set-TssUserOwner

## SYNOPSIS
Add or remove group owners of a user

## SYNTAX

```
Set-TssUserOwner [-TssSession] <Session> -Id <Int32> [-AddGroupId <Int32[]>] [-RemoveAllOwners]
 [-RemoveGroupId <Int32[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds and removes groups as owners of a user in one call, or removes every owner so the user is managed by user administrators again.
Add-TssUserOwner adds a single user or group owner.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserOwner -TssSession $session -Id 42 -AddGroupId 8 -RemoveGroupId 9
```

Adds group 8 and removes group 9 as owners of user 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserOwner -TssSession $session -Id 42 -RemoveAllOwners
```

Removes every owner of user 42

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
User ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddGroupId
IDs of the groups to add as owners

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

### -RemoveAllOwners
Remove every owner so the user is managed by user administrators

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

### -RemoveGroupId
IDs of the groups to remove as owners

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

### Thycotic.PowerShell.Users.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Set-TssUserOwner](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Set-TssUserOwner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Set-TssUserOwner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Set-TssUserOwner.ps1)
