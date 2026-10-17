---
title: Get-TssNotificationStatus
parent: Inbox
grand_parent: Commands
---
# Get-TssNotificationStatus

## SYNOPSIS
Get the notification counts of the current user

## SYNTAX

```
Get-TssNotificationStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the counts behind the notification bell for the current user: system alerts, new inbox notifications and pending secret access, secret erase and application requests, plus when the notifications were last viewed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssNotificationStatus -TssSession $session
```

Get the notification counts of the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssNotificationStatus -TssSession $session).SecretAccessRequestPendingTotal
```

Show how many secret access requests wait for the current user

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.NotificationStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssNotificationStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssNotificationStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssNotificationStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssNotificationStatus.ps1)
