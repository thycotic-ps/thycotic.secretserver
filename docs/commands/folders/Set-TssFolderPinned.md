---
title: Set-TssFolderPinned
parent: Folders
grand_parent: Commands
---
# Set-TssFolderPinned

## SYNOPSIS
Pin a folder or update its pin settings for the current user

## SYNTAX

```
Set-TssFolderPinned [-TssSession] <Session> -Id <Int32> [-ActiveFilter] [-DisplayName <String>]
 [-IncludeSubfolders] [-SearchText <String>] [-SelectedFolderId <Int32>] [-ShowCards] [-TemplateFilter <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Pins a folder for the current user, or updates the settings of an existing pin.
Only the parameters provided are changed; a folder that is not pinned yet is pinned with the values given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderPinned -TssSession $session -Id 42
```

Pins folder 42 for the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderPinned -TssSession $session -Id 42 -DisplayName 'Production servers' -ShowCards:$false -IncludeSubfolders
```

Renames the pin on folder 42 and switches it to the grid view with subfolders included

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
Folder ID to pin or update

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

### -ActiveFilter
Filter the pinned view to active secrets (true) or inactive secrets (false)

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

### -DisplayName
Name of the pin, visible only to the current user, shown in the pinned folders list

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

### -IncludeSubfolders
Include secrets in subfolders when browsing from the pin

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

### -SearchText
Default search text for the pin

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

### -SelectedFolderId
Folder to select in the tree when the pin is opened

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowCards
Show secrets as cards instead of a grid for this pin

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

### -TemplateFilter
Secret template ID to filter the pinned view by

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Folders.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPinned](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPinned)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPinned.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPinned.ps1)
