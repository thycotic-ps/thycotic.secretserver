---
title: Get-TssInboxMessage
parent: Inbox
grand_parent: Commands
---
# Get-TssInboxMessage

## SYNOPSIS
Get an inbox message

## SYNTAX

```
Get-TssInboxMessage [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get an inbox message of the current user by ID, with its message type, details, data and recipients.
Secret Server 12.3 returns IsRead False from this route even for a read message; Search-TssInboxMessage reports the read status.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxMessage -TssSession $session -Id 112
```

Return inbox message 112

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
Inbox message ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: MessageId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.Message
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxMessage](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxMessage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxMessage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxMessage.ps1)
