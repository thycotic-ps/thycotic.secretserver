---
title: Get-TssRecordedSessionPointOfInterest
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssRecordedSessionPointOfInterest

## SYNOPSIS
Get the points of interest of a recorded session

## SYNTAX

```
Get-TssRecordedSessionPointOfInterest [-TssSession] <Session> -Id <Guid[]> [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the points of interest of one or more recorded sessions: keystrokes, applications and other activity captured during the session, with their offset from the session start.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRecordedSessionPointOfInterest -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a
```

Get the points of interest of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRecordedSessionPointOfInterest -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -SearchText sudo
```

Get the SSH keystroke points of interest of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a that match sudo

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

### -SearchText
Text to filter the SSH keystroke points of interest by. Secret Server applies it only to SSH (proxied) sessions; RDP keystroke and application points of interest are always returned unfiltered

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.RecordedSessions.PointOfInterest[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionPointOfInterest](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionPointOfInterest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionPointOfInterest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionPointOfInterest.ps1)
