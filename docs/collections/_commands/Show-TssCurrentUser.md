---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Show-TssCurrentUser
schema: 2.0.0
title: Show-TssCurrentUser
---

# Show-TssCurrentUser

## SYNOPSIS
Show the current user of the current session

## SYNTAX

```
Show-TssCurrentUser [-TssSession] <TssSession> [<CommonParameters>]
```

## DESCRIPTION
Show the current user of the current session

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Show-TssCurrentUser -TssSession $session
```

Shows details on the current session's user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$currentUser = Show-TssCurrentUser -TssSession $session
$currentUser.GetPermissions()
```

Get the current user for the session and output a sorted list of Secret Server permissions assigned

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
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

### TssCurrentUser
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Show-TssCurrentUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/Show-TssCurrentUser)

