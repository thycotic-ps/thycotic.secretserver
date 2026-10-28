---
title: Invoke-TssRecordedSessionRequestProcessing
parent: Recorded Sessions
grand_parent: Commands
---
# Invoke-TssRecordedSessionRequestProcessing

## SYNOPSIS
Request processing of a recorded session video

## SYNTAX

```
Invoke-TssRecordedSessionRequestProcessing [-TssSession] <Session> -Id <Guid[]>
 [<CommonParameters>]
```

## DESCRIPTION
Asks Secret Server to encode or transcode the video of one or more recorded sessions now instead of waiting for the scheduled processing.
Returns the processing status and the time estimate Secret Server reports.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssRecordedSessionRequestProcessing -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a
```

Request processing of the video of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

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

### Thycotic.PowerShell.RecordedSessions.ProcessingRequest
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing.ps1)
