---
title: Get-TssSlackConfiguration
parent: Slack
grand_parent: Commands
---
# Get-TssSlackConfiguration

## SYNOPSIS
Get the Slack integration configuration

## SYNTAX

```
Get-TssSlackConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the Slack integration settings: the Slack app ID, whether secret interactions and inbox notifications are sent to Slack, and whether the current user has a Slack ID.
The result includes the Slack signature key and bot token in clear text: treat the output as secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSlackConfiguration -TssSession $session | Select-Object AppId, SecretInteractionsEnabled, InboxNotificationsEnabled
```

Show the Slack settings without the signature key and bot token

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSlackConfiguration -TssSession $session).CurrentUserHasSlackId
```

Check whether the current user has a Slack ID

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

### Thycotic.PowerShell.Slack.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Get-TssSlackConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Get-TssSlackConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Get-TssSlackConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Get-TssSlackConfiguration.ps1)
