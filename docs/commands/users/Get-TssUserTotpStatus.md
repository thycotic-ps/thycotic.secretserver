---
title: Get-TssUserTotpStatus
parent: Users
grand_parent: Commands
---
# Get-TssUserTotpStatus

## SYNOPSIS
Get the authenticator app setup of the current user

## SYNTAX

```
Get-TssUserTotpStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the TOTP account name, secret key and otpauth URL for setting up an authenticator app for the current user.
The output is key material: the secret key and URL generate valid one-time codes for the account.
Fails when TOTP two-factor authentication is not enabled for the current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserTotpStatus -TssSession $session
```

Returns the authenticator app setup of the current user

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Users.TotpStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserTotpStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserTotpStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserTotpStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserTotpStatus.ps1)
