---
title: Reset-TssUserTwoFactor
parent: Users
grand_parent: Commands
---
# Reset-TssUserTwoFactor

## SYNOPSIS
Reset the two-factor authentication of a user

## SYNTAX

```
Reset-TssUserTwoFactor [-TssSession] <Session> -Id <Int32[]> -TwoFactorType <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Resets the TOTP or FIDO2 two-factor enrollment of a user.
The user sets it up again at the next login.
Fails with access denied when the user is not enrolled in that method.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Reset-TssUserTwoFactor -TssSession $session -Id 42 -TwoFactorType Oath
```

Resets the TOTP enrollment of user 42

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
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TwoFactorType
Two-factor method to reset: Oath (TOTP) or Fido (FIDO2)

```yaml
Type: String
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserTwoFactor](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserTwoFactor)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserTwoFactor.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserTwoFactor.ps1)
