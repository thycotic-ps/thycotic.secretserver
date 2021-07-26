---
title: "ScanItemFields"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.ScanItemFields class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.ScanItemFields

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.ScanItemFields class represents the SecretDependencyScanItemField object returned by Secret Server endpoint GET /secret-dependencies/stub

# CONSTRUCTORS
    new()

# PROPERTIES
    Id: integer (int32)
        Id of the ScanItemField

    Name: string
        Name of the ScanItemField

    ParentName: string
        ScanItemField Parent name. Will Match Name if no parent is inherited.

    Value: string
        Value of the ScanItemField

# METHODS

# RELATED LINKS:
    Get-TssSecretDependencyStub