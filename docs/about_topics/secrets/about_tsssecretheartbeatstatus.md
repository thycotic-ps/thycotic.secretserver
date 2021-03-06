---
title: "TssSecretHeartbeatStatus"
---

# TOPIC
    This help topic describes the TssSecretHeartbeatStatus class in the Thycotic.SecretServer module

# CLASS
    TssSecretHeartbeatStatus

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretHeartbeatStatus class represents the object returned by Secret Server endpoint GET /internals/secret-detail/{id}/heartbeat-status

# CONSTRUCTORS
    new()

# PROPERTIES
    Status
        Heartbeat Status (Failed, Success, Pending, Disabled, UnableToConnect, UnknownError, IncompatibleHost, AccountLockedOut, DnsMismatch, UnableToValidateServerPublicKey, Processing)

    LastHeartbeatCheck
        Date and time of last heartbeat check

# METHODS

# RELATED LINKS:
    Get-TssSecretHeartbeatStatus