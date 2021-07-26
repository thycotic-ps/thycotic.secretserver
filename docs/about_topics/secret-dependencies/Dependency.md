---
title: "Dependency"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.Dependency class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.Dependency

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.Dependency class represents the SecretDependencyModel object returned by Secret Server endpoint GET /secret-dependencies/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Whether or not the Secret Dependency is active.

    ChildDependencyStatus: boolean
        The last run status of the child Secret Dependency.

    ConditionDependencyId: integer (int32)
        The Id of the dependency that will be looked at when Condition Mode is set to 'DEPENDENCYPASS', 'DEPENDENCYFAIL'. The Dependency must have a SortOrder lower than the current one.

    ConditionMode: string
        Condition Mode governs if this dependency's run relies on the result of other dependencies above it. The Default is ALWAYSRUN. Other values maybe 'All Pass', 'Any Fail', 'DEPENDENCYPASS', 'DEPENDENCYFAIL'.

    DependencyTemplate: DependencyTemplate
        The DependencyTemplate properties that are populated if the Dependency is based on a Dependency template.

    Description: string
        A description for the Secret Dependency.

    GroupId: integer (int32)
        The Id of the Dependency Group that contains the Secret Dependency.

    Id: integer (int32)
        The Id of the Secret Dependency.

    LogMessage: string
        The last Log message for the Secret Dependency.

    PrivilegedAccountSecretId: integer (int32)
        The Id of the Privileged Secret that the Secret Dependency will use to run.

    RunScript: SecretDependencyRunScript
        The RunScript properties that are populated if the Dependency is directly running a script.

    SecretDependencyStatus: boolean
        The last run status of the Secret Dependency.

    SecretId: integer (int32)
        The Id of the Secret that the Secret Dependency is assigned to.

    SecretName: string
        The Name of the Secret that the Secret Dependency is assigned to.

    Settings: object[]
        The Settings used by the Secret Dependency. (Ex: WaitBeforeSeconds, Database, Port, SSHKeyDigest). If a setting exists with the same name (or intent in the case of Port and SqlPort) as a field on the Dependency template's DependencyScanItemFields collection, the value assigned to the setting takes precedence and will overwrite the corresponding DependencyScanItemField.

    SortOrder: integer (int32)
        The sort order of the Secret Dependency in the group. Determines the order of execution of the dependencies within a group.

    SshKeySecretId: integer (int32)
        The Id of the Secret containing the SSH key. (If dependency is tied to SSH key Secret

    SshKeySecretName: string
        The Name of the Secret containing the SSH key. (If dependency is tied to SSH key Secret

    TypeId: integer (int32)
        The Id of the type of Secret Dependency.

    TypeName: string
        The name of the type of Secret Dependency.

# METHODS

# RELATED LINKS:
    Get-TssSecretDependency