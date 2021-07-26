---
title: "AuditSummary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Users.AuditSummary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Users.AuditSummary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Users.AuditSummary class represents the UserAuditSummary object returned by Secret Server endpoint GET /users/{id}/audit

# CONSTRUCTORS
    new()

# PROPERTIES
    Action
        Action that occurred

    DatabaseName
        Database name

    DateRecorded
        Date Recorded

    DisplayName
        The name of the user that made the change

    DisplayNameAffected
        The display name that was affected by this change

    IpAddress
        IP Address

    MachineName
        Machine name

    Notes
        Notes

    UserId
        The user id of the user that made the change

    UserIdAffected
        The user id that was affected by this change

# METHODS

# RELATED LINKS:
    Get-TssUserAudit