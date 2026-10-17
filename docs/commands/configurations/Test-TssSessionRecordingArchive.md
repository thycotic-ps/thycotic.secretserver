---
title: Test-TssSessionRecordingArchive
parent: Configurations
grand_parent: Commands
---
# Test-TssSessionRecordingArchive

## SYNOPSIS
Test the session recording archive location

## SYNTAX

```
Test-TssSessionRecordingArchive [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Tests that Secret Server can write to the configured session recording archive location.
Returns Success and the message Secret Server reports.
Secret Server returns an error (Archiving is not enabled) while session recording archiving is off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSessionRecordingArchive -TssSession $session
```

Test the configured session recording archive location

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.SessionRecordingArchiveTest
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSessionRecordingArchive](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSessionRecordingArchive)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSessionRecordingArchive.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSessionRecordingArchive.ps1)
