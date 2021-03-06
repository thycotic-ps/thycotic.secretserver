---
title: "TssPasswordType"
---

# TOPIC
    This help topic describes the TssPasswordType class in the Thycotic.SecretServer module

# CLASS
    TssPasswordType

# INHERITANCE
    None

# DESCRIPTION
    The TssPasswordType class represents the PasswordTypeModel object returned by Secret Server endpoint GET /remote-password-changing/password-types/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Whether the Password Type is Active

    CanEdit: boolean
        Whether the Password Type can be edited

    CustomPort: integer (int32)
        Custom Port

    ExitCommand: string
        Exit Command

    Fields: TssPasswordTypeField[]
        Password Type Fields

    HasCommands: boolean
        Whether Commands Exist

    HasLDAPSettings: boolean
        Whether LDAP Settings Exist

    HeartbeatScriptArgs: string
        Heartbeat Script Args

    HeartbeatScriptId: integer (int32)
        Heartbeat Script Id

    IgnoreSSL: boolean
        Whether Password Type ignores SSL warnings

    IsWeb: boolean
        Whether Is Web

    LdapConnectionSettingsId: integer (int32)
        LDAP Connection Settings Id

    LineEnding: LineEnding
        Line ending type (NewLine, CarriageReturn, CarriageReturnNewLine)

    MainframeConnectionString: string
        Mainframe Connection String

    Name: string
        Password Type Name

    OdbcConnectionString: string
        ODBC Connection String

    PasswordTypeId: integer (int32)
        Password Type Id

    RpcScriptArgs: string
        RPC Script Args

    RpcScriptId: integer (int32)
        RPC Script Id

    RunnerType: RunnerType
        Runner Type (Standard, Legacy, Null)

    ScanItemTemplateId: integer (int32)
        Scan Template Id

    TypeName: string
        Federator Type

    UseSSL: boolean
        Whether Password Type uses SSL

    UseUsernameAndPassword: boolean
        Whether Password Type uses both Username and Password

    ValidForTakeover: boolean
        Whether is Valid For Takeover

    WindowsCustomPorts: string
        Custom Ports for Windows

# METHODS

# RELATED LINKS:
    Get-TssRpcPasswordType