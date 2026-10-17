---
title: New-TssInboxTemplateLocale
parent: Inbox
grand_parent: Commands
---
# New-TssInboxTemplateLocale

## SYNOPSIS
Add a locale to an inbox notification template

## SYNTAX

```
New-TssInboxTemplateLocale [-TssSession] <Session> -TemplateId <Int32> -LocaleCultureId <Int32>
 -Subject <String> -TemplateBody <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds a subject and body for another locale culture to an inbox notification template.
A template has one locale per locale culture ID: adding a culture the template already has is rejected.
Change an existing locale with Set-TssInboxTemplateLocale.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 10 -Subject 'Secret geaendert' -TemplateBody '<p>$Details</p>'
```

Add locale culture 10 to inbox template 15

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 10 -Subject 'Test' -TemplateBody '<p>Test</p>' -WhatIf
```

Show the request without adding the locale

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

### -TemplateId
Inbox template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: InboxTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LocaleCultureId
Locale culture ID of the new locale

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Subject for this locale

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateBody
Body for this locale (HTML for email templates)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.Inbox.TemplateLocale
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateLocale](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateLocale)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateLocale.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateLocale.ps1)
