---
title: "CurrentUser"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Users.CurrentUser class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Users.CurrentUser

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Users.CurrentUser class represents the CurrentUser object returned by Secret Server endpoint GET /users/current

# CONSTRUCTORS
    new()

# PROPERTIES
    AdminLinks MenuLink[]
        List of Admin link options for the current user

    DateOptionId
        Date option for the current user

    DisplayName
        Display Name of the current user

    EmailAddress
        Email address of the current user

    Id
        User ID of the current user

    Permissions RolePermission[]
        Permissions assigned to the current user

    ProfileLinks MenuLink[]
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

# RELATED LINKS:
    Show-TssCurrentUser