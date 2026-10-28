---
title: Add-TssUserRole
parent: Users
grand_parent: Commands
---
# Add-TssUserRole

## SYNOPSIS
Add roles to a user

## SYNTAX

```
Add-TssUserRole [-TssSession] <Session> -Id <Int32> -RoleId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Assigns one or more roles to a user.
Roles the user already has are kept.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssUserRole -TssSession $session -Id 42 -RoleId 3, 5
```

Adds roles 3 and 5 to user 42

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

### -RoleId
IDs of the roles to add

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Add-TssUserRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Add-TssUserRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Add-TssUserRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Add-TssUserRole.ps1)
