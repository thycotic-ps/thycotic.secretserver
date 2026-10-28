---
title: Search-TssNotification
parent: Inbox
grand_parent: Commands
---
# Search-TssNotification

## SYNOPSIS
Search the system alert notifications of the current user

## SYNTAX

```
Search-TssNotification [-TssSession] <Session> [-IncludeArchived] [-MarkAlertsAsViewed]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the system alerts shown to the current user in the notification bell, such as missing email configuration or an unset custom URL, with their read state.
The list is not paged.
Use -MarkAlertsAsViewed to also mark the alerts as viewed, as opening the notification panel does.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssNotification -TssSession $session
```

List the current system alerts

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssNotification -TssSession $session | Where-Object { -not $_.IsRead } | Set-TssNotificationRead -TssSession $session
```

Mark every unread system alert as read

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

### -IncludeArchived
Include archived notifications

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

### -MarkAlertsAsViewed
Also mark the alerts as viewed (changes the user's notification state)

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

### Thycotic.PowerShell.Inbox.Notification
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssNotification](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssNotification)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssNotification.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssNotification.ps1)
