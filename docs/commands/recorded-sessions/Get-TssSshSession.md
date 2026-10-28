---
title: Get-TssSshSession
parent: Recorded Sessions
grand_parent: Commands
---
# Get-TssSshSession

## SYNOPSIS
Get the data of an SSH proxy session

## SYNTAX

```
Get-TssSshSession [-TssSession] <Session> [-AuditSecretId <Int32>] [-ByteLimit <Int64>] [-FilterType <String>]
 [-SearchTerm <String>] [-SecretSessionId <Int32>] [-SecretSessionKey <String>] [-SessionGuid <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the recorded data of an SSH proxy session: the commands and output of the session.
Identify the session by one of SecretSessionId, SecretSessionKey, SessionGuid or AuditSecretId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshSession -TssSession $session -SecretSessionId 786
```

Get the data of SSH proxy session 786

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshSession -TssSession $session -SecretSessionId 786 -FilterType Client -SearchTerm sudo
```

Get the client side lines of SSH proxy session 786 that match sudo

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

### -ByteLimit
Maximum number of bytes of session data to return

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterType
Side of the SSH transcript to return: Both, Client or Server (default Both)

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
Return only session data matching this text

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.RecordedSessions.SshSession
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSession.ps1)
