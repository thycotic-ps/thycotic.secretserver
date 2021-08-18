# Close-TssSession

## SYNOPSIS
Expire the current session to Secret Server

## SYNTAX

```
Close-TssSession [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Expire the current session to Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Close-TssSession -TssSession $session
```

Close the session, expiring the access token were it is no longer usable

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Close-TssSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Close-TssSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Close-TssSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Close-TssSession.ps1)

