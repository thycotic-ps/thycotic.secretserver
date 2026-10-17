---
title: Set-TssFolderPermission
parent: Folders
grand_parent: Commands
---
# Set-TssFolderPermission

## SYNOPSIS
Add, update or remove permissions on a folder in one call

## SYNTAX

```
Set-TssFolderPermission [-TssSession] <Session> -Id <Int32> [-AddOrUpdateItems <Object[]>] [-AllowRemoveOwner]
 [-InheritPermissions] [-RemoveItems <Object[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Applies a subset of permission changes to a folder: users or groups in AddOrUpdateItems are granted or updated, users or groups in RemoveItems are removed, and existing permissions not named are left as they are.
With InheritPermissions set to true every other change is ignored and the folder goes back to inheriting permissions from its parent.
With InheritPermissions set to false inheritance is broken first and then the changes are applied.
A top-level folder cannot be set to inherit permissions, and personal folders do not allow inheritance changes.
Use New-TssFolderPermission or Update-TssFolderPermission to manage a single permission row by name.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderPermission -TssSession $session -Id 42 -InheritPermissions:$false -AddOrUpdateItems @{ groupId = 3; folderAccessRoleId = 12; secretAccessRoleId = 12 }
```

Breaks inheritance on folder 42 and grants group 3 the folder and secret roles with ID 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderPermission -TssSession $session -Id 42 -RemoveItems @{ userId = 5 }, @{ groupId = 7 }
```

Removes user 5 and group 7 from the permissions on folder 42

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderPermission -TssSession $session -Id 42 -InheritPermissions
```

Resets folder 42 to inherit permissions from its parent folder

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

### -AddOrUpdateItems
Permissions to add or update, each a hashtable or object with userId or groupId (groupId wins when both are set), folderAccessRoleId, secretAccessRoleId, and optionally editDependencies and manageTotp.
Role IDs are integers, as returned by Get-TssFolderPermission (FolderAccessRoleId, SecretAccessRoleId)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowRemoveOwner
Allow the change to remove the current user's own edit access to the folder.
Without it the request fails when it would do so

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

### -InheritPermissions
True resets the folder to inherit permissions and ignores the other changes.
False breaks inheritance and then applies the changes

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

### -RemoveItems
Users or groups to remove from the folder permissions, each a hashtable or object with userId or groupId

```yaml
Type: Object[]
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

### Thycotic.PowerShell.Folders.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPermission.ps1)
