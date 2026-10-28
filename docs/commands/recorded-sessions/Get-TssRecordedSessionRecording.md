---
title: Get-TssRecordedSessionRecording
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssRecordedSessionRecording

## SYNOPSIS
Save the video of a recorded session

## SYNTAX

```
Get-TssRecordedSessionRecording [-TssSession] <Session> -Id <Guid[]> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads the video of one or more recorded sessions to a folder and returns the saved files.
The file name is the one Secret Server returns for the video; when none is returned the file is named recorded-session-\<Id\> with the extension of the video type.
A session with no processed video saves no file and writes a warning; Invoke-TssRecordedSessionRequestProcessing asks Secret Server to process it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRecordedSessionRecording -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -Output .\recordings
```

Saves the video of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a to the recordings folder

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRecordedSession -TssSession $session -SecretIds 42 -DateRange 7 | Get-TssRecordedSessionRecording -TssSession $session -Output .\recordings
```

Saves the videos of the sessions of secret 42 from the last 7 days

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

### -Output
Folder to save the files in

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionRecording](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionRecording)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionRecording.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionRecording.ps1)
