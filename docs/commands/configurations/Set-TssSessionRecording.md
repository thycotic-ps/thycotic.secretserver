---
title: Set-TssSessionRecording
parent: Configurations
grand_parent: Commands
---
# Set-TssSessionRecording

## SYNOPSIS
Set the session recording configuration

## SYNTAX

```
Set-TssSessionRecording [-TssSession] <Session> [-ArchiveLocationBySite] [-ArchivePath <String>]
 [-ArchivePathMappings <Object[]>] [-DaysUntilArchive <Int32>] [-DaysUntilDelete <Int32>] [-EnableArchive]
 [-EnableDelete] [-EnableHardwareAcceleration] [-EnableInactivityTimeout] [-EnableOnDemandVideoProcessing]
 [-EnableSessionRecording] [-EncryptArchive] [-HideRecordingIndicator] [-InactivityTimeoutMinutes <Int32>]
 [-MaxSessionLength <Int32>] [-RdpProxyRecordKeyStrokes] [-RdpProxyRecordVideo] [-SshProxyRecordKeyStrokes]
 [-SshProxyRecordVideo] [-StoreInDatabase] [-UseTemporaryArchives] [-VideoCodecId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the session recording settings on the Configuration Session Recording tab.
Only the parameters given are changed.
Returns the updated configuration.
Every setting other than EnableSessionRecording is saved only while session recording is enabled, already or by -EnableSessionRecording in the same call; otherwise Secret Server ignores it and returns the current settings.
SSH and RDP proxy recording settings are saved only while that proxy is enabled.
Secret Server rejects every change while launchers are disabled (Launcher must be enabled to import these settings).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSessionRecording -TssSession $session -EnableSessionRecording -MaxSessionLength 4
```

Enable session recording and limit recorded sessions to 4 hours

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSessionRecording -TssSession $session -EnableArchive -ArchivePath D:\Recordings -DaysUntilArchive 30
```

Archive session recordings to a share after 30 days

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

### -ArchiveLocationBySite
Archive to a separate location per site (ArchivePathMappings)

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

### -ArchivePath
Folder session recordings are archived to

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

### -ArchivePathMappings
Archive folder per site: objects with SiteId and Path properties, for example @{ SiteId = 1; Path = 'D:\Recordings\Site1' }

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DaysUntilArchive
Days after which session recordings are archived

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

### -DaysUntilDelete
Days after which session recordings are deleted

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

### -EnableArchive
Archive session recordings after DaysUntilArchive

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

### -EnableDelete
Delete session recordings after DaysUntilDelete

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

### -EnableHardwareAcceleration
Use hardware acceleration for video processing

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

### -EnableInactivityTimeout
End recorded sessions after InactivityTimeoutMinutes without activity

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

### -EnableOnDemandVideoProcessing
Process session videos only when they are requested

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

### -EnableSessionRecording
Enable session recording; -EnableSessionRecording:$false disables it

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

### -EncryptArchive
Encrypt archived session recordings

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

### -HideRecordingIndicator
Hide the recording indicator during sessions

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

### -InactivityTimeoutMinutes
Minutes without activity before a recorded session ends

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

### -MaxSessionLength
Maximum recorded session length in hours

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

### -RdpProxyRecordKeyStrokes
Record keystrokes of RDP proxy sessions

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

### -RdpProxyRecordVideo
Record video of RDP proxy sessions

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

### -SshProxyRecordKeyStrokes
Record keystrokes of SSH proxy sessions

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

### -SshProxyRecordVideo
Record video of SSH proxy sessions

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

### -StoreInDatabase
Store session recordings in the database

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

### -UseTemporaryArchives
Use temporary archives while processing

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

### -VideoCodecId
ID of the video codec used to encode session recordings

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.Configuration.SessionRecording
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssSessionRecording](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssSessionRecording)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssSessionRecording.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssSessionRecording.ps1)
