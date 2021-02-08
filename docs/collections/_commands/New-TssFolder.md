---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecret
schema: 2.0.0
title: New-TssFolder
---

# New-TssFolder

## SYNOPSIS
Create a new folde

## SYNTAX

```
New-TssFolder [-TssSession] <TssSession> [-FolderStub] <TssFolder> -FolderName <String> -ParentFolderId <Int32>
 [-SecretPolicyId <Int32>] [-InheritPermissions] [-InheritSecretPolicy] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderStub = Get-TssFolderStub -TssSession $session
New-TssFolder -TssSession $session -FolderStub $folderStub -FolderName 'tssNewFolder' -ParentFolderId -1
```

Creates a folder named "tssNewFolder" at the root of Secret Server application

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderStub = Get-TssFolderStub -TssSession $session
New-TssFolder -TssSession $session -FolderStub $folderStub -FolderName 'IT Dept' -ParentFolderId 27 -InheritPermissions:$false
```

Creates a folder named "IT Dept" under parent folder 27 with Inherit Permissins disabled (set to No if viewed in the UI)

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderStub -TssSession $session | New-TssFolder -TssSession $session -FolderName 'Marketing Dept' -ParentFolderId 27 -InheritPermissions -InheritSecretPolicy
```

Creates a folder named "Marketing Dept" under parent folder 27 with inheritance enabled for Permissions and Secret Policy

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

### -FolderName
Folder Name

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

### -ParentFolderId
Parent Folder ID, use -1 to create root folder

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ParentFolder

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPolicyId
Secret Policy ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretPolicy

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritPermissions
Inherit Permissions

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritSecretPolicy
Inherit Secret Policy

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### TssSecret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecret)

