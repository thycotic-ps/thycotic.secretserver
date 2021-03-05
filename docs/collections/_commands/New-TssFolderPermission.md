---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolderPermission
schema: 2.0.0
title: New-TssFolderPermission
---

# New-TssFolderPermission

## SYNOPSIS
Create a new folder permission

## SYNTAX

```
New-TssFolderPermission [-TssSession] <TssSession> -FolderId <Int32> [-GroupId <Int32>] [-UserId <Int32>]
 -FolderAccessRoleName <String> -SecretAccessRoleName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new folder permission

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssFolderPermission -TssSession $session -FolderId 5 -UserId 21 -FolderAccessRoleName View -SecretAccessRoleName List
```

Creates a folder permission on Folder ID 5 for User ID 21 granting View on the Folder-level and List on the Secrets in the folder

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

### -FolderId
Folder ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -GroupId
Group Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -UserId
User ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FolderAccessRoleName
Folder Access Role Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SecretAccessRoleName
Secret Access Role Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

### TssFolderPermission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolderPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolderPermission)

