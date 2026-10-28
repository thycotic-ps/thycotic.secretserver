---
title: Get-TssFolderPermissionStub
parent: Folder Permissions
grand_parent: Commands
---
# Get-TssFolderPermissionStub

## SYNOPSIS
Get the default values for a new folder permission

## SYNTAX

```
Get-TssFolderPermissionStub [-TssSession] <Session> -FolderId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Get the default values for a new folder permission on a folder (permission ID 0, no user or group, default folder and secret roles).
Nothing is saved; use New-TssFolderPermission to add the permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderPermissionStub -TssSession $session -FolderId 27
```

Returns the default folder permission values for folder 27

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssFolderPermissionStub -TssSession $session -FolderId 27).FolderAccessRoleName
```

Returns the folder role a new permission on folder 27 gets by default

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

### -FolderId
Folder ID the new permission is for

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.FolderPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Get-TssFolderPermissionStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Get-TssFolderPermissionStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Get-TssFolderPermissionStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Get-TssFolderPermissionStub.ps1)
