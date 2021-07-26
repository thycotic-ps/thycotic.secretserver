---
title: "OwnerSummary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Users.OwnerSummary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Users.OwnerSummary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Users.OwnerSummary class represents the UserOwnerSummary object returned by Secret Server endpoint GET /users/{id}/owners

# CONSTRUCTORS
    new()

# PROPERTIES
    DomainId: integer (int32)
        Active Directory domain ID

    GroupId: integer (int32)
        Group ID

    Id: integer (int32)
        User owner ID

    IsUser: boolean
        Whether the owner is a user (true) or a group (false)

    Name: string
        User owner name

    UserId: integer (int32)
        User ID

# METHODS

# RELATED LINKS:
    Get-TssUserOwner