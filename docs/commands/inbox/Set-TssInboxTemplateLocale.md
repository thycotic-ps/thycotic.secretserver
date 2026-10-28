---
title: Set-TssInboxTemplateLocale
parent: Inbox
grand_parent: Commands
---
# Set-TssInboxTemplateLocale

## SYNOPSIS
Change the subject or body of an inbox template locale

## SYNTAX

```
Set-TssInboxTemplateLocale [-TssSession] <Session> -TemplateId <Int32> -LocaleCultureId <Int32>
 [-Subject <String>] [-TemplateBody <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes the subject or body an inbox notification template uses for one locale.
Only the values you pass are changed.
The locale must already exist on the template: add one with New-TssInboxTemplateLocale.
The locale is chosen by locale culture ID, not by template locale ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 9 -Subject 'Secret changed: $SecretName'
```

Change the subject of locale culture 9 on inbox template 15

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplate -TssSession $session -Id 15 | Set-TssInboxTemplateLocale -TssSession $session -TemplateBody (Get-Content .\body.html -Raw)
```

Replace the body of the default locale of inbox template 15 with the contents of body.html

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
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LocaleCultureId
Locale culture ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Locale, LocaleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Subject
New subject

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

### -TemplateBody
New body (HTML for email templates)

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplateLocale](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplateLocale)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplateLocale.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplateLocale.ps1)
