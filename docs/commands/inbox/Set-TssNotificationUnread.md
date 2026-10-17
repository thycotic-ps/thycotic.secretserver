---
title: Set-TssNotificationUnread
parent: Inbox
grand_parent: Commands
---
# Set-TssNotificationUnread

## SYNOPSIS
Mark system alert notifications as unread

## SYNTAX

```
Set-TssNotificationUnread [-TssSession] <Session> -NotificationId <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Marks one or more system alert notifications as unread again for the current user.
The server returns False when the user has no read record for the ID, such as an alert that was never marked read or an ID that does not exist.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssNotificationUnread -TssSession $session -NotificationId 'a5780772-5ee3-40d9-a257-a86b8e5c7052'
```

Mark one system alert as unread

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssNotification -TssSession $session | Where-Object IsRead | Set-TssNotificationUnread -TssSession $session
```

Mark every read system alert as unread

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

### -NotificationId
Notification ID (a GUID, the NotificationId property of Search-TssNotification output)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationUnread](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationUnread)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationUnread.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationUnread.ps1)
