---
title: Copy-TssInboxTemplate
parent: Inbox
grand_parent: Commands
---
# Copy-TssInboxTemplate

## SYNOPSIS
Copy an inbox notification template

## SYNTAX

```
Copy-TssInboxTemplate [-TssSession] <Session> -Id <Int32> -Name <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new inbox notification template as a copy of an existing one, under a new name.
The copy is never a system template, so it can be changed with Set-TssInboxTemplate and Set-TssInboxTemplateLocale even when the source is a built-in template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Copy-TssInboxTemplate -TssSession $session -Id 4 -Name 'Password Reset (branded)'
```

Copy template 4 to a new template named Password Reset (branded)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplate -TssSession $session -TemplateType Slack | Select-Object -First 1 | Copy-TssInboxTemplate -TssSession $session -Name 'Team Slack'
```

Copy the first Slack template to a new template named Team Slack

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
ID of the inbox template to copy

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId, InboxTemplateIdToCopy

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Name of the new template

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

### Thycotic.PowerShell.Inbox.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Copy-TssInboxTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Copy-TssInboxTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Copy-TssInboxTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Copy-TssInboxTemplate.ps1)
