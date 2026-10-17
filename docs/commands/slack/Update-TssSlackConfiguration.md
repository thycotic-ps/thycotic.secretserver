---
title: Update-TssSlackConfiguration
parent: Slack
grand_parent: Commands
---
# Update-TssSlackConfiguration

## SYNOPSIS
Update the Slack integration configuration

## SYNTAX

```
Update-TssSlackConfiguration [-TssSession] <Session> [-AppId <String>] [-BotToken <SecureString>]
 [-InboxNotificationsEnabled] [-SecretInteractionsEnabled] [-SignatureKey <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the Slack integration settings.
Only the values you pass are changed.
The signature key and bot token are taken as secure strings and are not shown in verbose or WhatIf output.
The result, like Get-TssSlackConfiguration, includes them in clear text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSlackConfiguration -TssSession $session -SecretInteractionsEnabled -InboxNotificationsEnabled
```

Turn on secret interactions and inbox notifications in Slack

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSlackConfiguration -TssSession $session -AppId A0123456789 -BotToken (Read-Host -AsSecureString) -SignatureKey (Read-Host -AsSecureString)
```

Set the Slack app ID, bot token and signature key

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

### -AppId
Slack app ID

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

### -BotToken
Slack bot token

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InboxNotificationsEnabled
Send inbox notifications to Slack.
Pass -InboxNotificationsEnabled:$false to turn it off

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

### -SecretInteractionsEnabled
Send secret notifications to Slack and allow secret interactions from Slack.
Pass -SecretInteractionsEnabled:$false to turn it off

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

### -SignatureKey
Slack signing secret (signature key)

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.Slack.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Update-TssSlackConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Update-TssSlackConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Update-TssSlackConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Update-TssSlackConfiguration.ps1)
