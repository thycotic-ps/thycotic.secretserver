---
title: Search-TssUserSession
parent: Users
grand_parent: Commands
---
# Search-TssUserSession

## SYNOPSIS
List the login sessions of the current user

## SYNTAX

```
Search-TssUserSession [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the web login sessions of the user who owns the session, with IP address, login date and browser.
Current is True for the session that made the request.
API token sessions are not listed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserSession -TssSession $session
```

Lists the login sessions of the current user

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

### Thycotic.PowerShell.Users.Session[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserSession.ps1)
