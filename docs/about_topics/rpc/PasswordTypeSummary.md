---
title: "PasswordTypeSummary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Rpc.PasswordTypeSummary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Rpc.PasswordTypeSummary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Rpc.PasswordTypeSummary class represents the PasswordTypeSummary object returned by Secret Server endpoint GET /remote-password-changing/password-types

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Whether the Password Type is Active

    CanEdit: boolean
        Whether the Password Type can be edited

    HasCommands: boolean
        Whether Commands Exist

    HeartbeatScriptId: integer (int32)
        Heartbeat Script Id

    IgnoreSSL: boolean
        Whether Password Type ignores SSL warnings

    IsWeb: boolean
        Whether Is Web

    Name: string
        Password Type Name

    PasswordTypeId: integer (int32)
        Password Type Id

    RequiredEdition: string
        Required Edition (Standard, Legacy, Null)

    RpcScriptId: integer (int32)
        RPC Script Id

    RunnerType: RunnerType
        Runner Type

    ScanItemTemplateId: integer (int32)
        Scan Template Id

    UseSSL: boolean
        Whether Password Type uses SSL

# METHODS

# RELATED LINKS:
    Search-TssRpcPasswordType