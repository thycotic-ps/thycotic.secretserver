---
title: Get-TssRecordedSessionInstaller
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssRecordedSessionInstaller

## SYNOPSIS
Save the Advanced Session Recording Agent installer

## SYNTAX

```
Get-TssRecordedSessionInstaller [-TssSession] <Session> -Id <Int32[]> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads the Advanced Session Recording Agent (ASRA) installer zip of one or more launcher agent collections to a folder and returns the saved files.
The file name is the one Secret Server returns; when none is returned the file is named asra-installer-\<Id\>.zip.
The installer is large, so each download waits up to one hour.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRecordedSessionInstaller -TssSession $session -Id 1 -Output .\installers
```

Saves the session recording agent installer of launcher agent collection 1 to the installers folder

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
Launcher agent collection ID (not a recorded session ID)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: LauncherAgentCollectionId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionInstaller](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionInstaller)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionInstaller.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionInstaller.ps1)
