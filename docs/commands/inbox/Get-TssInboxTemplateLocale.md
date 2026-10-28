---
title: Get-TssInboxTemplateLocale
parent: Inbox
grand_parent: Commands
---
# Get-TssInboxTemplateLocale

## SYNOPSIS
Get the subject and body of an inbox template locale

## SYNTAX

```
Get-TssInboxTemplateLocale [-TssSession] <Session> -TemplateId <Int32> -LocaleCultureId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the subject and body an inbox notification template uses for one locale.
The locale is chosen by locale culture ID (the Locale property of Get-TssInboxTemplate output is the default one).
When the template has no locale for that culture, the server returns the template's default locale instead: check LocaleCultureId on the result.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplateLocale -TssSession $session -TemplateId 4 -LocaleCultureId 9
```

Get locale culture 9 of inbox template 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplate -TssSession $session -Id 4 | Get-TssInboxTemplateLocale -TssSession $session
```

Get the default locale of inbox template 4

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.TemplateLocale
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateLocale](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateLocale)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateLocale.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateLocale.ps1)
