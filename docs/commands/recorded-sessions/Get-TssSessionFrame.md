---
title: Get-TssSessionFrame
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSessionFrame

## SYNOPSIS
Get the captured frames of a recorded session

## SYNTAX

```
Get-TssSessionFrame [-TssSession] <Session> -SecretSessionId <Int32> [-TopImageIdRecovered <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns up to 1000 captured screen frames of a recorded session, oldest first, with their image ID and capture time.
Pass the last image ID returned as TopImageIdRecovered to get the next frames.
Use Get-TssSessionImage to download a frame.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionFrame -TssSession $session -SecretSessionId 786
```

Get the first 1000 captured frames of secret session 786

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionFrame -TssSession $session -SecretSessionId 786 -TopImageIdRecovered 1000
```

Get the next frames after image 1000

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

### -SecretSessionId
Secret session ID (SecretSessionId in Search-TssRecordedSession output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TopImageIdRecovered
Return only frames after this image ID (default 0, from the start of the session)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.RecordedSessions.SessionFrame[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionFrame](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionFrame)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionFrame.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionFrame.ps1)
