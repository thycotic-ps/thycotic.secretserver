---
title: Remove-TssUser
parent: Users
grand_parent: Commands
---
# Remove-TssUser

## SYNOPSIS
Delete a user, which deactivates the account

## SYNTAX

```
Remove-TssUser [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sends DELETE for each user ID.
Secret Server does not erase the user: it disables the account and records the change in the user audit.
Fails with access denied for a user that is already disabled, a system user, the calling user or a Platform service user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssUser -TssSession $session -Id 42
```

Deletes (deactivates) user 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUser -TssSession $session -SearchText olduser | Remove-TssUser -TssSession $session -WhatIf
```

Shows which users matching olduser would be deleted

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
ID of the user to delete

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-TssUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-TssUser.ps1)
