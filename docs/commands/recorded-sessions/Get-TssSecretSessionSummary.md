---
title: Get-TssSecretSessionSummary
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSecretSessionSummary

## SYNOPSIS
Get the summary of a secret session

## SYNTAX

```
Get-TssSecretSessionSummary [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the summary of one or more secret sessions by secret session ID: secret, user, machine, start and end time, and whether the recording can be played back.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretSessionSummary -TssSession $session -Id 786
```

Get the summary of secret session 786

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -Active | Get-TssSecretSessionSummary -TssSession $session
```

Get the secret session summary of every active recorded session

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
Secret session ID (SecretSessionId in Search-TssRecordedSession output)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretSessionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.RecordedSessions.SecretSessionSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSecretSessionSummary](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSecretSessionSummary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSecretSessionSummary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSecretSessionSummary.ps1)
