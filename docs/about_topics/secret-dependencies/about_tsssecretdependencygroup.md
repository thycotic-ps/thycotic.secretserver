---
title: "TssSecretDependencyGroup"
---

# TOPIC
    This help topic describes the TssSecretDependencyGroup class in the Thycotic.SecretServer module

# CLASS
    TssSecretDependencyGroup

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretDependencyGroup class represents the SecretDependencyGroup object returned by Secret Server endpoint POST /secret-dependencies/groups/{secretId}

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