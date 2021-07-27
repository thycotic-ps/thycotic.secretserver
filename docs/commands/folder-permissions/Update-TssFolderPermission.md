# Update-TssFolderPermission

## SYNOPSIS
Update properties for a given FolderPermission

## SYNTAX

```
Update-TssFolderPermission [-TssSession] <Session> -Id <Int32[]> -FolderId <Int32>
 -FolderAccessRolename <String> [-SecretAccessRoleName <String>] [-BreakInheritance] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update properties for a given FolderPermission

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssFolderPermission -TssSession $session -Id 34 -FolderId 5 -FolderAccessRoleName Edit -SecretAccessRoleName View
```

Update Folder Permission ID 34 on Folder ID 5 to Edit folder permission and View secret permission

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssFolderPermission -TssSession $session -Id 45 -FolderId 72 -FolderAccessRoleName Owner
```

Update Folder Permission ID 45 on Folder ID 72 to Owner folder permission

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
Folder Permission Id to modify

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderPermissionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FolderAccessRolename
Role to grant on the folder: View, Edit, Add Secret, Owner

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretAccessRoleName
Role to grant on the secret: View, Edit, List, Owner

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

### -BreakInheritance
Allow updating of inherited permissions

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

### Thycotic.PowerShell.FolderPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Update-TssFolderPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Update-TssFolderPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Update-TssFolderPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Update-TssFolderPermission.ps1)

