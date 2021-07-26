---
title: "GroupOwner"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Groups.GroupOwner class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Groups.GroupOwner

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Groups.GroupOwner class represents the GroupOwner object returned by Secret Server endpoint GET /groups/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    GroupId: integer (int32)
        The group ID, or personal group ID in the case of a user

    Name: string
        The display name for the user or group

    UserId: integer (int32)
        The user ID, or null in the case of a group

# METHODS

# RELATED LINKS:
    Get-TssGroup