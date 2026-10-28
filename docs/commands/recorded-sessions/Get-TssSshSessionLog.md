---
title: Get-TssSshSessionLog
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSshSessionLog

## SYNOPSIS
Save the log of an SSH proxy session

## SYNTAX

```
Get-TssSshSessionLog [-TssSession] <Session> [-SecretSessionId <Int32>] [-SecretSessionKey <String>]
 [-SessionGuid <String>] [-AuditSecretId <Int32>] [-FilterType <String>] [-SearchTerm <String>]
 -Output <String> [<CommonParameters>]
```

## DESCRIPTION
Downloads the text log of an SSH proxy session to a folder and returns the saved file.
Identify the session by one of SecretSessionId, SecretSessionKey, SessionGuid or AuditSecretId.
The file is named SSHSessionLog-\<session\>.txt.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshSessionLog -TssSession $session -SecretSessionId 786 -Output .\logs
```

Saves the log of SSH proxy session 786 to the logs folder

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshSessionLog -TssSession $session -SecretSessionId 786 -FilterType Client -Output .\logs
```

Saves only the client side of SSH proxy session 786

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

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretSessionKey
Secret session key

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

### -SessionGuid
Launcher session GUID

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

### -AuditSecretId
Secret audit record ID of the launch

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

### -FilterType
Side of the SSH transcript to save: Both, Client or Server (default Both)

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

### -SearchTerm
Save only the lines matching this text

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionLog.ps1)
