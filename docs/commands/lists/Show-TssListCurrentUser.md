# Show-TssListCurrentUser

## SYNOPSIS
Return a list of the Lists for the current user

## SYNTAX

```
Show-TssListCurrentUser [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Return a list of the Lists for the current user

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Show-TssListCurrentUser -TssSession $session
```

Returns the list of Lists the current connected user can access

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

### Thycotic.PowerShell.Lists.SummaryList
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Show-TssListCurrentUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Show-TssListCurrentUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Show-TssListCurrentUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Show-TssListCurrentUser.ps1)

