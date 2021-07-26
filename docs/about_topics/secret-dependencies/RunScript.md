---
title: "RunScript"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.RunScript class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.RunScript

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.RunScript class represents the SecretDependencyRunScript object returned by Secret Server endpoint GET /secret-dependencies/stub

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
    Get-TssSecretDependencyRunScriptStub