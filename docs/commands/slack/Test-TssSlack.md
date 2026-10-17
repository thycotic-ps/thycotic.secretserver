---
title: Test-TssSlack
parent: Slack
grand_parent: Commands
---
# Test-TssSlack

## SYNOPSIS
Send a test message to Slack

## SYNTAX

```
Test-TssSlack [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Sends a test Slack message with the saved Slack configuration and returns True when Slack accepted it.
Returns False, not an error, when Slack is not configured or rejects the message.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSlack -TssSession $session
```

Check that the saved Slack configuration can send a message

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
if (-not (Test-TssSlack -TssSession $session)) { Get-TssSlackConfiguration -TssSession $session | Select-Object AppId, SecretInteractionsEnabled, InboxNotificationsEnabled }
```

Show the Slack settings when the test fails

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Test-TssSlack](https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Test-TssSlack)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Test-TssSlack.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Test-TssSlack.ps1)
