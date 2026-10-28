---
title: Send-TssInboxTestMessage
parent: Inbox
grand_parent: Commands
---
# Send-TssInboxTestMessage

## SYNOPSIS
Send a test inbox message

## SYNTAX

```
Send-TssInboxTestMessage [-TssSession] <Session> -Subject <String> -Message <String> [-GroupId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sends a test message through the inbox to the current user, or to the members of a group, to check inbox and email delivery.
EmailConfigured on the result is False when email (SMTP) is not configured: the message then only reaches the inbox.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Send-TssInboxTestMessage -TssSession $session -Subject 'Inbox test' -Message 'Testing inbox delivery'
```

Send a test message to the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Send-TssInboxTestMessage -TssSession $session -Subject 'Inbox test' -Message 'Testing inbox delivery' -GroupId 5
```

Send a test message to the members of group 5

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

### -Subject
Subject of the test message

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

### -Message
Body of the test message

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

### -GroupId
Send the message to the members of this group instead of the current user

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

### Thycotic.PowerShell.Inbox.TestMessageResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Send-TssInboxTestMessage](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Send-TssInboxTestMessage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Send-TssInboxTestMessage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Send-TssInboxTestMessage.ps1)
