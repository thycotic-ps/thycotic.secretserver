---
title: Search-TssInboxTemplate
parent: Inbox
grand_parent: Commands
---
# Search-TssInboxTemplate

## SYNOPSIS
Search inbox notification templates

## SYNTAX

```
Search-TssInboxTemplate [-TssSession] <Session> [-TemplateType <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the inbox notification templates, both built-in system templates and custom ones, with the inbox rules that use each template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplate -TssSession $session
```

List every inbox notification template

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplate -TssSession $session -TemplateType Email | Where-Object { -not $_.IsSystem }
```

List the custom email templates

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

### -TemplateType
Only return templates of this type: Email or Slack

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.TemplateSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxTemplate.ps1)
