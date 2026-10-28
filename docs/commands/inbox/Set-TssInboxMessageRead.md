---
title: Set-TssInboxMessageRead
parent: Inbox
grand_parent: Commands
---
# Set-TssInboxMessageRead

## SYNOPSIS
Mark inbox messages as read or unread

## SYNTAX

```
Set-TssInboxMessageRead [-TssSession] <Session> -Id <Int32[]> [-Unread]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Mark one or more inbox messages of the current user as read, or as unread with -Unread.
Returns True when the server accepted the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxMessageRead -TssSession $session -Id 112, 113
```

Mark inbox messages 112 and 113 as read

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxMessage -TssSession $session -ReadStatus Read -MessageTypeId 4 | Set-TssInboxMessageRead -TssSession $session -Unread
```

Mark every read message of inbox message type 4 as unread

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
Inbox message IDs

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

### -Unread
Mark the messages as unread instead of read

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxMessageRead](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxMessageRead)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxMessageRead.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxMessageRead.ps1)
