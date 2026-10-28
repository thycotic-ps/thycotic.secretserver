---
title: Add-TssUserOwner
parent: Users
grand_parent: Commands
---
# Add-TssUserOwner

## SYNOPSIS
Add an owner to a user

## SYNTAX

```
Add-TssUserOwner [-TssSession] <Session> -Id <Int32> [-OwnerUserId <Int32>] [-OwnerGroupId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds one user or one group as an owner of a user.
Supply -OwnerUserId or -OwnerGroupId.
Returns the new owner record.
Set-TssUserOwner adds and removes several group owners in one call.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssUserOwner -TssSession $session -Id 42 -OwnerGroupId 8
```

Makes group 8 an owner of user 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssUserOwner -TssSession $session -Id 42 -OwnerUserId 5
```

Makes user 5 an owner of user 42

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

### -OwnerUserId
ID of the user to add as owner

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

### -OwnerGroupId
ID of the group to add as owner

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

### Thycotic.PowerShell.Users.OwnerSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Add-TssUserOwner](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Add-TssUserOwner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Add-TssUserOwner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Add-TssUserOwner.ps1)
