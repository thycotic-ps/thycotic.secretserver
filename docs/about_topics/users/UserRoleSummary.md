---
title: "UserRoleSummary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Users.UserRoleSummary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Users.UserRoleSummary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Users.UserRoleSummary class represents the UserRoleSummary object returned by Secret Server endpoint GET /users/{userid}/roles-assigned

# CONSTRUCTORS
    new()

# PROPERTIES
    RoleId
        Role ID assigned to user

    RoleName
        Name of role assigned to user

    IsDirectAssignment
        Is role directly assigned to the user

    Groups GroupAssignedRole
        Groups to which the user belongs that have the role

# METHODS

# RELATED LINKS:
    Get-TssUserRoleAssigned