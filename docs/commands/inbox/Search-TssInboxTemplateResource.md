---
title: Search-TssInboxTemplateResource
parent: Inbox
grand_parent: Commands
---
# Search-TssInboxTemplateResource

## SYNOPSIS
Search the images used by inbox notification templates

## SYNTAX

```
Search-TssInboxTemplateResource [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Lists the embedded inbox template resources: the PNG and JPG images that inbox notification templates reference by slug.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplateResource -TssSession $session
```

List every inbox template resource

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxTemplateResource -TssSession $session | Where-Object InboxResourceType -EQ 'Png'
```

List the PNG resources

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.TemplateResourceSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxTemplateResource](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxTemplateResource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxTemplateResource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxTemplateResource.ps1)
