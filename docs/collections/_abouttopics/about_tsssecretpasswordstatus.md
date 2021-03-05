---
category: secrets
title: "TssSecretPasswordStatus"
last_modified_at: 2021-03-03T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecretPasswordStatus class in the Thycotic.SecretServer module

# CLASS
    TssSecretPasswordStatus

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretPasswordStatus class represents and object returned by an internal endpoint to Secret Server

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