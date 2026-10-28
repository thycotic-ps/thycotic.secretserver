---
title: Add-TssFolderTemplate
parent: Folders
grand_parent: Commands
---
# Add-TssFolderTemplate

## SYNOPSIS
Associate a secret template with a folder

## SYNTAX

```
Add-TssFolderTemplate [-TssSession] <Session> -Id <Int32> -TemplateId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows secrets based on the template to be created in the folder.
A folder with no associated templates allows any template.
Once a template is associated, only secrets based on associated templates can be created in the folder.
Use Remove-TssFolderTemplate to remove the association.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssFolderTemplate -TssSession $session -Id 23 -TemplateId 6001
```

Allows secrets based on template 6001 in folder 23

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssFolderTemplate -TssSession $session -Id 23 -TemplateId 6001, 6003
```

Allows secrets based on templates 6001 and 6003 in folder 23

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
Folder ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FolderId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TemplateId
Secret template ID to associate with the folder

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Folders.TemplateAssociation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderTemplate.ps1)
