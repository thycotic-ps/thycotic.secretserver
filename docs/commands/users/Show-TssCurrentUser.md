# Show-TssCurrentUser

## SYNOPSIS
Show the current user of the current session

## SYNTAX

```
Show-TssCurrentUser [-TssSession] <Session> [<CommonParameters>]
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

### Thycotic.PowerShell.Users.CurrentUser
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Show-TssCurrentUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Show-TssCurrentUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Show-TssCurrentUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Show-TssCurrentUser.ps1)

