---
title: Get-TssInboxTemplate
parent: Inbox
grand_parent: Commands
---
# Get-TssInboxTemplate

## SYNOPSIS
Get an inbox notification template

## SYNTAX

```
Get-TssInboxTemplate [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets one or more inbox notification templates by ID.
Locale is the locale culture ID of the template's default locale.
Pass it with the template ID to Get-TssInboxTemplateLocale to read the subject and body.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplate -TssSession $session -Id 4
```

Get inbox template 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplate -TssSession $session -Id 4 | Get-TssInboxTemplateLocale -TssSession $session
```

Get the subject and body of the default locale of inbox template 4

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

### -Id
Inbox template ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TemplateId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplate.ps1)
