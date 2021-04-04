---
category: roles,users
title: "TssUserRoleSummary"
last_modified_at: 2021-03-03T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssUserRoleSummary class in the Thycotic.SecretServer module

# CLASS
    TssUserRoleSummary

# INHERITANCE
    None

# DESCRIPTION
    The TssUserRoleSummary class represents the UserRoleSummary object returned by Secret Server endpoint GET /users/{userid}/roles-assigned

# CONSTRUCTORS
    new()

# PROPERTIES
    RoleId
        Role ID assigned to user

    RoleName
        Name of role assigned to user

    IsDirectAssignment
        Is role directly assigned to the user

    Groups [TssGroupAssignedRole]
        Groups to which the user belongs that have the role

# METHODS

# RELATED LINKS:
    Get-TssUserRoleAssigned