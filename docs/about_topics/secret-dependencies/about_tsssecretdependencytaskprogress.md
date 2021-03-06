---
title: "TssSecretDependencyTaskProgress"
---

# TOPIC
    This help topic describes the TssSecretDependencyTaskProgress class in the Thycotic.SecretServer module

# CLASS
    TssSecretDependencyTaskProgress

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretDependencyTaskProgress class represents the TaskProgress object returned by Secret Server endpoint GET /secret-dependencies/run

# CONSTRUCTORS
    new()

# PROPERTIES
    Errors: TssSecretDependencyTaskError[]
        A list of errors for the task

    IsComplete: boolean
        True if the task is complete

    PercentageComplete: integer (int32)
        The estimated percentage complete of the task

    Status: string
        The current status of the task

    TaskIdentifier: string
        The task identifier

# METHODS

# RELATED LINKS:
    Get-TssSecretDependencyRunStatus