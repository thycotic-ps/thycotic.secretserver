---
title: Search-TssInboxMessageType
parent: Inbox
grand_parent: Commands
---
# Search-TssInboxMessageType

## SYNOPSIS
Search the inbox message types

## SYNTAX

```
Search-TssInboxMessageType [-TssSession] <Session> [-IncludeCurrentUserMessageCounts]
 [<CommonParameters>]
```

## DESCRIPTION
Search the inbox message types (for example Password Reset, Event Subscription).
With IncludeCurrentUserMessageCounts the server returns only the types the current user has notifications for, with NotificationCount set.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxMessageType -TssSession $session
```

Return every inbox message type

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxMessageType -TssSession $session -IncludeCurrentUserMessageCounts
```

Return the inbox message types the current user has notifications for, with the count of each

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

### -IncludeCurrentUserMessageCounts
Return only the types the current user has notifications for, with their count

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.MessageType[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessageType](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessageType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessageType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessageType.ps1)
