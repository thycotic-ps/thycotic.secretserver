---
title: Get-TssSshSessionReplayData
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSshSessionReplayData

## SYNOPSIS
Get the replay data of an SSH proxy session

## SYNTAX

```
Get-TssSshSessionReplayData [-TssSession] <Session> -SecretSessionId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the replay data of an SSH proxy session, the JSON text the web replay viewer plays back.
Secret Server returns an error for a session with no replay data.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshSessionReplayData -TssSession $session -SecretSessionId 786
```

Get the replay data of SSH proxy session 786

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionReplayData](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionReplayData)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionReplayData.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionReplayData.ps1)
