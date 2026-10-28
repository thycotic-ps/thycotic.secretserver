---
title: Remove-TssFolderPinned
parent: Folders
grand_parent: Commands
---
# Remove-TssFolderPinned

## SYNOPSIS
Unpin a folder for the current user

## SYNTAX

```
Remove-TssFolderPinned [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Unpins a folder for the current user and removes the settings saved for that pin.
Succeeds when the folder is not pinned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssFolderPinned -TssSession $session -Id 42
```

Unpins folder 42 for the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderPinned -TssSession $session | Remove-TssFolderPinned -TssSession $session
```

Unpins every folder the current user has pinned

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
Folder ID to unpin

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderId

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

### Thycotic.PowerShell.Folders.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Remove-TssFolderPinned](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Remove-TssFolderPinned)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-TssFolderPinned.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-TssFolderPinned.ps1)
