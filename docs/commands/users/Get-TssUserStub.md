---
title: Get-TssUserStub
parent: Users
grand_parent: Commands
---
# Get-TssUserStub

## SYNOPSIS
Get the default values for a new user

## SYNTAX

```
Get-TssUserStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns a user object with the default values Secret Server uses for a new user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserStub -TssSession $session
```

Returns the default values for a new user

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

### Thycotic.PowerShell.Users.Stub
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserStub.ps1)
