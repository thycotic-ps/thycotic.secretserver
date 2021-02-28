---
category: folder-permissions
title: "TssFolderPermission"
last_modified_at: 2021-02-24T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssFolderPermission class in the Thycotic.SecretServer module

# CLASS
    TssFolderPermission

# INHERITANCE
    None

# DESCRIPTION
    The TssFolderPermission class represents the FolderPermissionModel object returned by Secret Server endpoint GET /folder-permissions/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    FolderAccessRoleId
        Folder Access Role Id

    FolderAccessRoleName
        Permission on the folder

    GroupId
        Group Id

    SecretAccessRoleId
        Secret Access Role Id

    SecretAccessRoleName
        Permission on the secrets in the folder

# METHODS

# RELATED LINKS:
    Get-TssFolderPermission
    Get-TssFolderPermissionStub
    New-TssFolderPermission