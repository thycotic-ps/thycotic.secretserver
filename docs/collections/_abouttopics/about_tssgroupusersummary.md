---
category: groups
title: "TssGroupUserSummary"
last_modified_at: 2021-04-25T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssGroupUserSummary class in the Thycotic.SecretServer module

# CLASS
    TssGroupUserSummary

# INHERITANCE
    None

# DESCRIPTION
    The TssGroupUserSummary class represents the GroupUserSummary object returned by Secret Server endpoint GET /groups/{id}/users

# CONSTRUCTORS
    new()

# PROPERTIES
    DisplayName: string
        User display name

    Enabled: boolean
        User Enabled

    GroupDomainId: integer (int32)
        Group Active Directory domain ID

    GroupDomainName: string
        Group Domain Name

    GroupId: integer (int32)
        Group ID

    GroupName: string
        Group name

    UserDomainId: integer (int32)
        User Active Directory domain ID

    UserDomainName: string
        User Active Directory domain name

    UserId: integer (int32)
        User ID

    Username: string
        Username

# METHODS

# RELATED LINKS:
    Get-TssGroupMember
    Get-TssUserGroup