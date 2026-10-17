---
title: Update-TssDoubleLockPassword
parent: Users
grand_parent: Commands
---
# Update-TssDoubleLockPassword

## SYNOPSIS
Unlock DoubleLock for the current user with their DoubleLock password

## SYNTAX

```
Update-TssDoubleLockPassword [-TssSession] <Session> -Password <SecureString>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Verifies the existing DoubleLock password of the user who owns the session and unlocks DoubleLock for that user, so DoubleLock secrets can be read.
The server keeps the unlock per user, not per session: every session of the same user is unlocked, for up to an hour.
A new sign-in by the same user ends the unlock for all of that user's sessions, so call it again after signing in.
It does not create or change a DoubleLock password.
A user without a DoubleLock password gets the error "User has not created a QuantumLock password." (QuantumLock is the former name of DoubleLock).
A wrong password fails, and repeated wrong passwords block further attempts for a few minutes.
Returns True on success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDoubleLockPassword -TssSession $session -Password (Read-Host -AsSecureString)
```

Prompts for the DoubleLock password of the current user and unlocks DoubleLock for that user

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

### -Password
Current DoubleLock password of the user who owns the session

```yaml
Type: SecureString
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDoubleLockPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDoubleLockPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDoubleLockPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDoubleLockPassword.ps1)
