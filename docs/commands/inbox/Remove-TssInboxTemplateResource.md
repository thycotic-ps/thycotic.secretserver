---
title: Remove-TssInboxTemplateResource
parent: Inbox
grand_parent: Commands
---
# Remove-TssInboxTemplateResource

## SYNOPSIS
Remove an image used by inbox notification templates

## SYNTAX

```
Remove-TssInboxTemplateResource [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes one or more embedded inbox template resources by ID.
The server reports success even when the ID does not exist.
Use Search-TssInboxTemplateResource to confirm the removal.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssInboxTemplateResource -TssSession $session -Id 3
```

Remove inbox template resource 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplateResource -TssSession $session | Where-Object InboxResourceSlug -EQ 'old-logo' | Remove-TssInboxTemplateResource -TssSession $session
```

Remove the resource with the slug old-logo

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
Inbox template resource ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: InboxResourceId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Remove-TssInboxTemplateResource](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Remove-TssInboxTemplateResource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Remove-TssInboxTemplateResource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Remove-TssInboxTemplateResource.ps1)
