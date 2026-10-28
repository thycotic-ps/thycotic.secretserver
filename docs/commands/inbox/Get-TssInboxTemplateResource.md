---
title: Get-TssInboxTemplateResource
parent: Inbox
grand_parent: Commands
---
# Get-TssInboxTemplateResource

## SYNOPSIS
Get an image used by inbox notification templates

## SYNTAX

```
Get-TssInboxTemplateResource [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets one or more embedded inbox template resources by ID: the slug templates use to reference the image, its type and the image itself as a base64 string in ImageData.
The server answers access denied for an ID that does not exist.
Use Search-TssInboxTemplateResource to find IDs.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxTemplateResource -TssSession $session -Id 3
```

Get inbox template resource 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$resource = Get-TssInboxTemplateResource -TssSession $session -Id 3
[System.IO.File]::WriteAllBytes("$PWD\$($resource.Name).png", [Convert]::FromBase64String($resource.ImageData))
```

Save the image of resource 3 to a file

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Inbox.TemplateResource
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateResource](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateResource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateResource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateResource.ps1)
