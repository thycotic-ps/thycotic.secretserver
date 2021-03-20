---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolder
schema: 2.0.0
title: New-TssFolder
---

# New-TssFolder

## SYNOPSIS
Create a new folder

## SYNTAX

```
New-TssFolder [-TssSession] <TssSession> [-FolderStub] <TssFolder> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderStub = Get-TssFolderStub -TssSession $session
$folderStub.FolderName = 'tssNewFolder'
$folderStub.ParentFolderId = -1
New-TssFolder -TssSession $session -FolderStub $folderStub
```

Creates a new root folder, named "tssNewFolder"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderStub = Get-TssFolderStub -TssSession $session
$folderStub.FolderName 'IT Dept'
$folderStub.ParentFolderId = 27
$folderStub.InheritPermissions = $false
New-TssFolder -TssSession $session -FolderStub $folderStub
```

Creates a folder named "IT Dept" under parent folder 27 with Inherit Permissins disabled

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderStub.FolderName 'Marketing Dept'
$folderStub.ParentFolderId = 27
$folderStub.InheritPermissions = $true
$folderStub.InheritSecretPolicy = $true
New-TssFolder -TssSession $session -FolderStub $folderStub
```

Creates a folder named "Marketing Dept" under parent folder 27 with Inheritance enabled for Permissions and Secret Policy

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FolderStub
Input object obtained via Get-TssFolderStub

```yaml
Type: TssFolder
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
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

### TssFolder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-Folder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-Folder.ps1)

