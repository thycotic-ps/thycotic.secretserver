---
title: "Thycotic.PowerShell.Secrets.HeartbeatStatus"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.HeartbeatStatus class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.HeartbeatStatus

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.HeartbeatStatus class represents the object returned by Secret Server endpoint GET /internals/secret-detail/{id}/heartbeat-status

# CONSTRUCTORS
    new()

# PROPERTIES
    Status
        Heartbeat Status (Failed, Success, Pending, Disabled, UnableToConnect, UnknownError, IncompatibleHost, AccountLockedOut, DnsMismatch, UnableToValidateServerPublicKey, Processing)

    LastHeartbeatCheck
        Date and time of last heartbeat check

# METHODS

# RELATED LINKS:
    Get-Thycotic.PowerShell.Secrets.HeartbeatStatus