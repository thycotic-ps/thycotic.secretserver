---
title: "PasswordStatus"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.PasswordStatus class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.PasswordStatus

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.PasswordStatus class represents and object returned by an internal endpoint to Secret Server

# CONSTRUCTORS
    new()

# PROPERTIES
    Status
        Status of password change (None, Pending, Success, Fail)

    LastRpcDate
        DateTime of last password change event

    RpcMessage
        Message from last password change event

    FailedAttempts
        Failed attempts based on password changing configuration for the Secret

    NextRpcDate
        DateTime of next RPC attempt based on password changing configuration for the Secret

# METHODS

# RELATED LINKS:
    Get-TssSecretPasswordStatus