---
title: "DependencyTemplate"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.DependencyTemplate class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.DependencyTemplate

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.DependencyTemplate class represents the SecretDependencyTemplate object returned by Secret Server endpoint GET /secret-dependencies/stub

# CONSTRUCTORS
    new()

# PROPERTIES
    ChangerScriptId: integer (int32)
        The id of the script (if any) used by the Dependency Template

    DependencyScanItemFields: ScanItemFields[]
        The Scan Item Fields used by the Dependency Template

    ScriptName: string
        The name of the script (if any) used by the Dependency Template

    SecretDependencyChangerId: integer (int32)
        The id of the Dependency Changer used by the Dependency Template

    SecretDependencyTemplateId: integer (int32)
        The id of the Dependency Template

# METHODS

# RELATED LINKS:
    Get-TssSecretDependencyStub