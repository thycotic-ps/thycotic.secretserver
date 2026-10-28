---
title: Stop-TssUserSession
parent: Users
grand_parent: Commands
---
# Stop-TssUserSession

## SYNOPSIS
End login sessions of the current user

## SYNTAX

```
Stop-TssUserSession [-TssSession] <Session> -UserSessionId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Ends one or more web login sessions of the user who owns the session.
Session IDs come from Search-TssUserSession.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Stop-TssUserSession -TssSession $session -UserSessionId 1012
```

Ends login session 1012 of the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserSession -TssSession $session | Where-Object { -not $_.Current } | Stop-TssUserSession -TssSession $session
```

Ends every login session of the current user except the one making the request

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

### -UserSessionId
IDs of the sessions to end

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Users.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Stop-TssUserSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Stop-TssUserSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Stop-TssUserSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Stop-TssUserSession.ps1)
