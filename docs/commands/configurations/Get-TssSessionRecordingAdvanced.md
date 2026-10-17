---
title: Get-TssSessionRecordingAdvanced
parent: Configurations
grand_parent: Commands
---
# Get-TssSessionRecordingAdvanced

## SYNOPSIS
Get the advanced session recording configuration

## SYNTAX

```
Get-TssSessionRecordingAdvanced [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Advanced Session Recording settings: whether advanced session recording is enabled and the callback URL the session recording agent reports to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSessionRecordingAdvanced -TssSession $session
```

Get the advanced session recording configuration

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

### Thycotic.PowerShell.Configuration.SessionRecordingAdvanced
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSessionRecordingAdvanced](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSessionRecordingAdvanced)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSessionRecordingAdvanced.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSessionRecordingAdvanced.ps1)
