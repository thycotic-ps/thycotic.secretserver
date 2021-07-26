---
title: "Group"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretDependencies.Group class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretDependencies.Group

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretDependencies.Group class represents the SecretDependencyGroup object returned by Secret Server endpoint POST /secret-dependencies/groups/{secretId}

# CONSTRUCTORS
    new()

# PROPERTIES
    Id: integer (int32)
        The Id of the Secret Dependency Group

    Name: string
        The name of the Secret Dependency Group

    SiteId: integer (int32)
        The Id of the Site that all dependencies in this group use

    SiteName: string
        The Name of the Site that all dependencies in this group use

    StatusFailedCount: integer (int32)
        Total Enabled Secret dependencies in this group with a Failed status

    StatusNotRunCount: integer (int32)
        Total Enabled Secret dependencies in this group that have not yet run

    StatusSuccessCount: integer (int32)
        Total Enabled Secret dependencies in this group with a Success status

    TotalDependencies: integer (int32)
        Total Enabled Secret dependencies in this group

# METHODS

# RELATED LINKS:
    New-TssSecretDependencyGroup
    Get-TssSecretDependencyGroup