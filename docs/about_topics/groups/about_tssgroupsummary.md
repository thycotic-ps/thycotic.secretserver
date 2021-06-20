---
title: "TssGroupSummary"
---

# TOPIC
    This help topic describes the TssGroupSummary class in the Thycotic.SecretServer module

# CLASS
    TssGroupSummary

# INHERITANCE
    None

# DESCRIPTION
    The TssGroupSummary class represents the GroupSummary object returned by Secret Server endpoint /groups

# CONSTRUCTORS
    new()

# PROPERTIES
    Created
        Created Date

    DomainGuid
        If this a synchronized group and the user requesting access has access this will be populated with the unique guid for the directory with a group search.

    DomainId
        Active Directory domain ID

    DomainName
        Active Directory domain name

    Enabled
        Whether the group is active

    Id
        Group ID

    MemberCount
        Number of members in group

    Name
        Group name

    Synchronized
        Whether the group is synchronized with Active Directory

    SynchronizeNow
        Active Directory Sync will only pull in members for domain groups that have this set to true.

# METHODS

# RELATED LINKS:
    Search-TssGroups