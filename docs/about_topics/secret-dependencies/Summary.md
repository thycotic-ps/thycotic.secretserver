---
title: "Summary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.Summary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.Summary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.Summary class represents the SecretDependencySummary object returned by Secret Server endpoint GET /secret-dependencies

# CONSTRUCTORS
    new()

# PROPERTIES
    Enabled: boolean
        Whether or not this dependency is enabled

    GroupId: integer (int32)
        The Id of the Dependency Group that contains the Secret Dependency

    Id: integer (int32)
        The Id of the Secret Dependency

    MachineName: string
        The machine name that the Secret Dependency runs on

    Order: integer (int32)
        The order for this dependency within its group

    RunResult: string
        The last run result for this dependency (Success , Failed , NotRun)

    SecretId: integer (int32)
        he Id of the Secret that the Secret Dependency is assigned to

    ServiceName: string
        The service name of the Secret Dependency

    TypeId: integer (int32)
        The Id of the type of Secret Dependency

    TypeName: string
        The name of the type of Secret Dependency

# METHODS

# RELATED LINKS:
    Search-TssSecretDependency