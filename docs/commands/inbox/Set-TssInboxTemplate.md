---
title: Set-TssInboxTemplate
parent: Inbox
grand_parent: Commands
---
# Set-TssInboxTemplate

## SYNOPSIS
Rename an inbox notification template or change its type

## SYNTAX

```
Set-TssInboxTemplate [-TssSession] <Session> -Id <Int32> [-TemplateName <String>] [-TemplateType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the name or type of a custom inbox notification template.
Only the values you pass are changed.
System templates cannot be changed: the server rejects the request.
Copy one with Copy-TssInboxTemplate and change the copy.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxTemplate -TssSession $session -Id 15 -TemplateName 'Weekly digest v2'
```

Rename inbox template 15

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssInboxTemplate -TssSession $session -Id 15 -TemplateType Slack -WhatIf
```

Show the request that would change template 15 to a Slack template

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
Type: Int32
Parameter Sets: (All)
Aliases: TemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TemplateName
New name of the template

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

### -TemplateType
New template type: Email or Slack

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

### Thycotic.PowerShell.Inbox.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplate.ps1)
