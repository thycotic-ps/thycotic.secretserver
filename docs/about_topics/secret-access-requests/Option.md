---
title: "Option"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.AccessRequests.Option class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.AccessRequests.Option

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.AccessRequests.Option class represents the SecretAccessOptionsModel object returned by Secret Server endpoint GET /secret-access-requests/secrets/{id}/options

# CONSTRUCTORS
    new()

# PROPERTIES
    CustomCheckoutIntervalDays: integer (int32)
        CustomCheckoutIntervalDays

    CustomCheckoutIntervalHours: integer (int32)
        CustomCheckoutIntervalHours

    CustomCheckoutIntervalMinutes: integer (int32)
        CustomCheckoutIntervalMinutes

    EditorsAlsoRequireApproval: boolean
        EditorsAlsoRequireApproval

    EnableDoubleLock: boolean
        EnableDoubleLock

    EnableRequiresApprovalForAccess: boolean
        EnableRequiresApprovalForAccess

    IsDefaultCheckoutInterval: boolean
        IsDefaultCheckoutInterval

    OwnersAndApproversAlsoRequireApproval: boolean
        OwnersAndApproversAlsoRequireApproval

    RequireCheckout: boolean
        RequireCheckout

    RequireCommentTicketNumber: boolean
        RequireCommentTicketNumber

# METHODS

# RELATED LINKS:
    Get-TssSecretAccessRequestOption