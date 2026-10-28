---
title: Get-TssSessionImage
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSessionImage

## SYNOPSIS
Save a captured screen image of a recorded session

## SYNTAX

### id (Default)
```
Get-TssSessionImage [-TssSession] <Session> -SecretSessionId <Int32> [-ImageId <Int32>] -Output <String>
 [<CommonParameters>]
```

### key
```
Get-TssSessionImage [-TssSession] <Session> -SecretSessionKey <String> [-ImageId <Int32>] -Output <String>
 [<CommonParameters>]
```

### guid
```
Get-TssSessionImage [-TssSession] <Session> -LauncherSessionGuid <Guid> [-ImageId <Int32>] -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads a captured screen image of a recorded session to a folder and returns the saved file.
Identify the session by secret session ID, secret session key or launcher session GUID.
Without ImageId the latest image is saved; Get-TssSessionFrame lists the image IDs.
The file is named session-image-\<session\>-\<ImageId or latest\> with the extension of the image type.
Secret Server returns an error for a session with no captured images.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionImage -TssSession $session -SecretSessionId 786 -Output .\images
```

Saves the latest captured image of secret session 786 to the images folder

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionFrame -TssSession $session -SecretSessionId 786 | Get-TssSessionImage -TssSession $session -SecretSessionId 786 -Output .\images
```

Saves every captured image of secret session 786

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionImage -TssSession $session -LauncherSessionGuid 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -ImageId 12 -Output .\images
```

Saves image 12 of the session with launcher session GUID 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

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
Parameter Sets: id
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretSessionKey
Secret session key

```yaml
Type: String
Parameter Sets: key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LauncherSessionGuid
Launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

```yaml
Type: Guid
Parameter Sets: guid
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ImageId
Image ID (ImageId in Get-TssSessionFrame output); omit for the latest image

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

### -Output
Folder to save the file in

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionImage](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionImage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionImage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionImage.ps1)
