---
title: "Permission"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretPermissions.Permission class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretPermissions.Perimssion

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretPermissions.Perimssion class represents the SecretPermission object returned by Secret Server endpoint GET /secret-permissions

# CONSTRUCTORS
    new()

# PROPERTIES
    GroupId: integer (int32)
        Group ID

    GroupName: string
        Group name

    Id: integer (int32)
        Secret permission ID

    KnownAs: string
        KnownAs

    SecretAccessRoleId: integer (int32)
        Granted role ID

    SecretAccessRoleName: string
        Granted role name

    SecretId: integer (int32)
        Secret ID

    UserId: integer (int32)
        User ID

    Username: string
        User name

# METHODS

# RELATED LINKS:
    Search-TssSecretPermission
    New-TssSecretPermission
    Update-TssSecretPermission