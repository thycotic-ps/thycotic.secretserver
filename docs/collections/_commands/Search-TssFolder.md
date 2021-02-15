---
category: folders
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssFolder
schema: 2.0.0
title: Search-TssFolder
---

# Search-TssFolder

## SYNOPSIS
Search secret folders

## SYNTAX

```
Search-TssFolder [-TssSession] <TssSession> [-ParentFolderId <Int32>] [-SearchText <String>]
 [-PermissionRequired <String>] [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search secret folders

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssFolder -TssSession $session -ParentFolderId 54
```

Return all child folders found under root folder 54

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

### -ParentFolderId
Parent Folder Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FolderId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Search by text value

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

### -PermissionRequired
Filter based on folder permission (Owner, Edit, AddSecret, View).
Default: View

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

### -SortBy
Sort by specific property, default FolderPath

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: FolderPath
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssFolderSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssFolder)

