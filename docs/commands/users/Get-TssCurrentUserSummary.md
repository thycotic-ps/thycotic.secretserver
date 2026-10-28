---
title: Get-TssCurrentUserSummary
parent: Users
grand_parent: Commands
---
# Get-TssCurrentUserSummary

## SYNOPSIS
Get the user ID of the current user

## SYNTAX

```
Get-TssCurrentUserSummary [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns a summary of the user who owns the session.
The summary carries only the user ID; Show-TssCurrentUser returns the full profile.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssCurrentUserSummary -TssSession $session
```

Returns the user ID of the current user

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

### Thycotic.PowerShell.Users.CurrentUserSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssCurrentUserSummary](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssCurrentUserSummary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssCurrentUserSummary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssCurrentUserSummary.ps1)
