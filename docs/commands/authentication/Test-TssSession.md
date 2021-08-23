# Test-TssSession

## SYNOPSIS
Test TssSession object

## SYNTAX

```
Test-TssSession [-TssSession] <Session> [-Session] [-Token] [-Ttl <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Test TssSession object

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSession -TssSession $session -Session
```

Test that the session is Valid

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSession -TssSession $session -Ttl 5
```

Test if TimeOfDeath for the session is less than or equal 5 minutes, returns false if it is, otherwise true

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSession -TssSession $session -Token
```

Verifies the token is valid

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

### -Session
Test for a valid Session object, verifies following:
   AccessToken has a value
   StartTime property is set on the object
   If TokenType is SdkClient or WindowsAuth will always return true

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
Test for a valid token, verifies following:
   AccessToken has a value
   TimeOfDeath is greater than current time
   If TokenType is SdkClient, Windows Auth, or ExternalToken will always return true

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ttl
Check token TTL (time-to-live), provide value in minutes
   Returns true if TotalMinutes \<= (Get-Date).AddMinutes(\<Ttl value\>), else false.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSession.ps1)

