---
title: New-TssInboxTemplateResource
parent: Inbox
grand_parent: Commands
---
# New-TssInboxTemplateResource

## SYNOPSIS
Upload an image for inbox notification templates

## SYNTAX

```
New-TssInboxTemplateResource [-TssSession] <Session> -Slug <String> -Path <String> [-FileName <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a PNG or JPG image as an embedded inbox template resource, so inbox notification templates can reference it by its slug.
The slug may only contain lower-case letters and hyphens, and must not already be in use: to replace an image, remove the old resource with Remove-TssInboxTemplateResource first.
The server checks the file content and rejects anything that is not a PNG or JPG image.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxTemplateResource -TssSession $session -Slug company-logo -Path .\logo.png
```

Upload logo.png as the resource company-logo

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssInboxTemplateResource -TssSession $session -Slug banner -Path .\banner.jpg -WhatIf
```

Show the upload without sending it

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

### -Slug
Name templates use to reference the image: lower-case letters and hyphens only

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

### -Path
Path of the PNG or JPG file to upload

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

### -FileName
File name to send with the image, the file name of -Path when omitted

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateResource](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateResource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateResource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateResource.ps1)
