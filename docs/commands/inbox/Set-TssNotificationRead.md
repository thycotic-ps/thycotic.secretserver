---
title: Set-TssNotificationRead
parent: Inbox
grand_parent: Commands
---
# Set-TssNotificationRead

## SYNOPSIS
Mark system alert notifications as read

## SYNTAX

```
Set-TssNotificationRead [-TssSession] <Session> -NotificationId <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Marks one or more system alert notifications as read for the current user.
The server returns True for any ID, including one that does not exist.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssNotificationRead -TssSession $session -NotificationId 'a5780772-5ee3-40d9-a257-a86b8e5c7052'
```

Mark one system alert as read

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssNotification -TssSession $session | Set-TssNotificationRead -TssSession $session
```

Mark every system alert as read

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationRead](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationRead)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationRead.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationRead.ps1)
