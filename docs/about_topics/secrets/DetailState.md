---
title: "DetailState"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.DetailState class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.DetailState

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.DetailState class represents the SecretDetailViewModel returned by Secret Server endpoint GET /secrets/{id}/state

# CONSTRUCTORS
    new()

# PROPERTIES
    Actions
        Allowed actions for the current user

    CheckedOutUserDisplayName
        Display Name of User that has the secret checked out

    CheckedOutUserId
        User Secret is checked out to

    CheckOutIntervalMinutes
        Number of minutes before checkout

    CheckOutMinutesRemaining
        Minutes remaining in check out

    FolderId
        Folder Id

    FolderName
        Folder Name

    Id
        Secret Id

    IsActive
        Active

    IsCheckedOut
        Is the Secret checked out

    IsCheckedOutByCurrentUser
        Indicates whether the Secret is checked out by the current user

    PasswordChangePending
        Pending Password change on secret indicator

    Role
        Role that current user has on Secret

    SecretName
        Secret Name

    SecretState
        Current State of the Secret

# METHODS
    [System.String[]] GetActions()
        Returns the Actions, sorted

# RELATED LINKS:
   Get-TssSecretState