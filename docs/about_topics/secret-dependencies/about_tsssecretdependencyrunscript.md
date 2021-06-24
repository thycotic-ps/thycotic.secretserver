---
title: "TssSecretDependencyRunScript"
---

# TOPIC
    This help topic describes the TssSecretDependencyRunScript class in the Thycotic.SecretServer module

# CLASS
    TssSecretDependencyRunScript

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretDependencyRunScript class represents the SecretDependencyRunScript object returned by Secret Server endpoint GET /secret-dependencies/stub

# CONSTRUCTORS
    new()

# PROPERTIES
    MachineName: string
        The machine name that the Secret Dependency runs on

    OdbcConnectionArguments: object[]
    Connection arguments used for ODBC connections

    ScriptArguments: object[]
        Parameter script arguments used by the script

    ScriptId: integer (int32)
        The Id of the script that the Secret Dependency runs. (If directly running a script)

    ScriptName: string
        The Name of the script that the Secret Dependency runs.

    ServiceName: string
        The service name of the Secret Dependency

# METHODS

# RELATED LINKS:
    TssSecretDependency
    Get-TssSecretDependencyRunScriptStub