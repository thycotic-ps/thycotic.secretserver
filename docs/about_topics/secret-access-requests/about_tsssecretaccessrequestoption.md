---
title: "TssSecretAccessRequestOption"
---

# TOPIC
    This help topic describes the TssSecretAccessRequestOption class in the Thycotic.SecretServer module

# CLASS
    TssSecretAccessRequestOption

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretAccessRequestOption class represents the SecretAccessOptionsModel object returned by Secret Server endpoint GET /secret-access-requests/secrets/{id}/options

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