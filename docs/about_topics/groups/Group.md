---
title: "Group"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Groups.Group class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Groups.Group

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Groups.Group class represents the GroupModel object returned by Secret Server endpoint GET /groups/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    AdGuid: string
        Active Directory unique identifier

    CanEditMembers: boolean
        Whether you can edit the members of this group. For example, Directory Services group members cannot be edited. Populated on a single group get.

    Created: string (date-time)
        Group created date

    DomainId: integer (int32)
        Active Directory Domain ID

    DomainName: string
        Active Directory domain name

    Enabled: boolean
        Whether the group is active

    HasGroupOwners: boolean
        If true, the group is owned by specific other users/groups. If false, if it is owned by Group Administrators.

    Id: integer (int32)
        Group ID

    IsEditable: boolean
        Whether you have permission to edit this group

    Name: string
        Group name

    OwnerGroups: object[]
        GroupIds and GroupName that own this group. Only used if HasGroupOwners is true.

    Owners: GroupOwner[]
        The owners for the group, both users and groups

    OwnerUsers: object[]
        UserIds and Usernames that own this group. Only used if HasGroupOwners is true.

    Synchronized: boolean
        Whether the group is synchronized with Active Directory

    SynchronizeNow: boolean
        Active Directory Sync will only pull in members for domain groups that have this set to true.

    SystemGroup: boolean
        Whether the group is an Active Directory system group

# METHODS

# RELATED LINKS:
    Get-TssGroup