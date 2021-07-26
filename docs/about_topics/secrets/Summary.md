---
title: "Summary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.Summary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.Summary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.Summary class represents the SecretSummary object returned by Secret Server endpoint GET /secrets and GET /secrets/{id}/summary

# CONSTRUCTORS
    new()

# PROPERTIES
    Active
        Whether the secret is active

    AutoChangeEnabled
        Indicates whether or not this Secret an auto changing password

    CheckedOut
        Whether the secret is currently checked out

    CheckOutEnabled
        Indicates whether or not checkout is enabled for the Secret

    CreateDate
        When the Secret was created

    DaysUntilExpiration
        How many days until this Secret expires

    DoubleLockEnabled
        Indicates whether or not DoubleLock is enabled for this password

    ExtendedFields [Thycotic.PowerShell.Secrets.SummaryExtendedField[]]
        Any requested extended fields from a lookup request

    FolderId
        Containing folder ID

    HidePassword
        Indicates if the launcher password is set to be hidden

    Id
        Secret ID

    InheritsPermissions
        Indicates if this Secret inherits permissions from its folder

    IsOutOfSync
        Out of sync indicates that a Password is setup for autochange and has failed its last password change attempt or has exceeded the maximum RPC attempts

    IsRestricted
        Whether the secret is restricted

    LastAccessed
        When the Secret was last viewed, only populated when scope is Recent

    LastHeartBeatStatus
        Current status of heartbeat (Failed, Success, Pending, Disabled, UnableToConnect, UnknownError, IncompatibleHost, AccountLockedOut, DnsMismatch, UnableToValidateServerPublicKey, Processing, ArgumentError, AccessDenied)

    LastPasswordChangeAttempt
        Time of most recent password change attempt

    Name
        Secret name

    OutOfSyncReason
        Reason message if the secret is out of sync

    RequiresApproval
        Indicates if this Secret requires approval

    RequiresComment
        Indicates if this Secret requires comment

    SecretTemplateId
        Secret template ID

    SecretTemplateName
        Name of secret template

    SiteId
        SiteId

# METHODS

# RELATED LINKS:
    Thycotic.PowerShell.Secrets.SummaryExtendedField
    Search-TssSecret
    Get-TssSecretSummary