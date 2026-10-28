---
title: Invoke-TssForgotPassword
parent: Users
grand_parent: Commands
---
# Invoke-TssForgotPassword

## SYNOPSIS
Send a password reset email to a user

## SYNTAX

```
Invoke-TssForgotPassword [-TssSession] <Session> -EmailAddress <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Requests a password reset for the user with this email address.
Secret Server emails a reset link when an enabled user matches the address and SMTP is configured.
Fails with access denied unless password reset by email is allowed in the Secret Server configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssForgotPassword -TssSession $session -EmailAddress user@example.com
```

Sends a password reset link to the user with the email address user@example.com

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

### -EmailAddress
Email address of the user who gets the reset link

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssForgotPassword](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssForgotPassword)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssForgotPassword.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssForgotPassword.ps1)
