---
title: Test-TssCurrentUserPassword
parent: Users
grand_parent: Commands
---
# Test-TssCurrentUserPassword

## SYNOPSIS
Test whether a password is the password of the current user

## SYNTAX

```
Test-TssCurrentUserPassword [-TssSession] <Session> -Password <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION
Verifies a password against the account of the user who owns the session.
Returns True when the password matches and False when it does not.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssCurrentUserPassword -TssSession $session -Password (Read-Host -AsSecureString)
```

Prompts for a password and returns True when it is the password of the current user

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
Password to verify

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Test-TssCurrentUserPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Test-TssCurrentUserPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Test-TssCurrentUserPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Test-TssCurrentUserPassword.ps1)
