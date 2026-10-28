---
title: Search-TssInboxMessage
parent: Inbox
grand_parent: Commands
---
# Search-TssInboxMessage

## SYNOPSIS
Search the inbox messages of the current user

## SYNTAX

```
Search-TssInboxMessage [-TssSession] <Session> [-MessageTypeId <Int32[]>] [-ReadStatus <String>]
 [-StartDate <DateTime>] [-EndDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Search the inbox messages of the current user, optionally by message type, read status and creation date.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxMessage -TssSession $session -ReadStatus Unread
```

Return the unread inbox messages of the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxMessage -TssSession $session -MessageTypeId 4 -StartDate (Get-Date).AddDays(-7)
```

Return the messages of inbox message type 4 created in the last seven days

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

### -MessageTypeId
Return only messages of these inbox message types (InboxMessageTypeId from Search-TssInboxMessageType)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: InboxMessageTypeId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadStatus
Return only Read or Unread messages (default All)

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

### -StartDate
Return only messages created on or after this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Return only messages created on or before this date

```yaml
Type: DateTime
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

### Thycotic.PowerShell.Inbox.Message[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessage](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessage.ps1)
