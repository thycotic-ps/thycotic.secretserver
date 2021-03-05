---
category: users
title: "TssCurrentUser"
last_modified_at: 2021-03-03T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssCurrentUser class in the Thycotic.SecretServer module

# CLASS
    TssCurrentUser

# INHERITANCE
    None

# DESCRIPTION
    The TssCurrentUser class represents the CurrentUser object returned by Secret Server endpoint GET /users/current

# CONSTRUCTORS
    new()

# PROPERTIES
    AdminLinks [TssMenuLink[]]
        List of Admin link options for the current user

    DateOptionId
        Date option for the current user

    DisplayName
        Display Name of the current user

    EmailAddress
        Email address of the current user

    Id
        User ID of the current user

    Permissions [TssRolePermission[]]
        Permissions assigned to the current user

    ProfileLinks [TssMenuLink[]]
        List of Profile options for the current user

    TimeOptionId
        Time option of the current user

    UserLcid
        Language of the current user

    Username
        Username of the current user

    UserTheme
        Current user's theme

# METHODS
    [TssRolePermission[]] GetPermissions()
        Returns the TssRolePermission object, sorted by Name

# RELATED LINKS:
    Show-TssCurrentUser