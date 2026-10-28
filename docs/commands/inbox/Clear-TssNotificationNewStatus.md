---
title: Clear-TssNotificationNewStatus
parent: Inbox
grand_parent: Commands
---
# Clear-TssNotificationNewStatus

## SYNOPSIS
Clear the new notification indicator for the current user

## SYNTAX

```
Clear-TssNotificationNewStatus [-TssSession] <Session> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Marks the current user's inbox notifications as viewed, which clears the new notification badge, as opening the inbox does.
Returns True on success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssNotificationNewStatus -TssSession $session
```

Clear the new notification indicator

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssNotificationNewStatus -TssSession $session; (Get-TssNotificationStatus -TssSession $session).InboxNotificationTotal
```

Clear the indicator and show that no new inbox notifications remain

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Clear-TssNotificationNewStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Clear-TssNotificationNewStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Clear-TssNotificationNewStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Clear-TssNotificationNewStatus.ps1)
