---
title: New-TssInboxTemplate
parent: Inbox
grand_parent: Commands
---
# New-TssInboxTemplate

## SYNOPSIS
Create an inbox notification template

## SYNTAX

```
New-TssInboxTemplate [-TssSession] <Session> -TemplateName <String> [-TemplateType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an empty inbox notification template that inbox rules can use for email or Slack messages.
The template gets a default locale with an empty subject and body.
Fill them in with Set-TssInboxTemplateLocale.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxTemplate -TssSession $session -TemplateName 'Weekly digest'
```

Create an email template named Weekly digest

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$template = New-TssInboxTemplate -TssSession $session -TemplateName 'Ops Slack' -TemplateType Slack
Set-TssInboxTemplateLocale -TssSession $session -TemplateId $template.TemplateId -LocaleCultureId $template.Locale -TemplateBody '$Details'
```

Create a Slack template and set the body of its default locale

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

### -TemplateName
Name of the template

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateType
Template type: Email (default) or Slack

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Email
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

### Thycotic.PowerShell.Inbox.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplate.ps1)
