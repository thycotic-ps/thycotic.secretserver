---
title: Get-TssRecordedSession
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssRecordedSession

## SYNOPSIS
Get a recorded session

## SYNTAX

```
Get-TssRecordedSession [-TssSession] <Session> -Id <Guid[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more recorded sessions: secret, user, machine, application, start and end time, and video processing state.
Use Search-TssRecordedSession to find the launcher session GUIDs.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRecordedSession -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a
```

Get recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -SearchText web01 | Get-TssRecordedSession -TssSession $session
```

Get the detail of every recorded session that matches web01

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
Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

```yaml
Type: Guid[]
Parameter Sets: (All)
Aliases: LauncherSessionGuid

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

### Thycotic.PowerShell.RecordedSessions.RecordedSession
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSession.ps1)
