# Update-TssUser

## SYNOPSIS
Update all members of a group

## SYNTAX

```
Update-TssUser [-TssSession] <Session> -Id <Int32> -User <User> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update all members of a group

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
$user = Get-TssUser -TssSession $session -Id 42
$user.DisplayName = 'New Display Name'
Update-TssUser -TssSession $session -Id 42 -User $user
```

Get the TssUser object via Get-TssUser, updating the display name on User 42

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
Type: Int32
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -User
User object from Get-TssUser

```yaml
Type: User
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

### Thycotic.PowerShell.Users.User
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUser.ps1)

