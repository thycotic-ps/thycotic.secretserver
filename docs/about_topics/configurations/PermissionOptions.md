---
title: "PermissionOptions"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.PermissionOptions class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.PermissionOptions

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.PermissionOptions class represents the ConfigurationPermissionOptionsModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    AllowDuplicateSecretNames: boolean
        Allow Secrets to have the same name in the same folder

    AllowViewUserToRetrieveAutoChangeNextPassword: boolean
        Users that only have secret view can see the next password

    DefaultSecretPermissions: string
        Default permissions to be applied when a Secret is created (InheritsPermissions, CopyFromFolder, OnlyAllowCreator)

    EnableApprovalFromEmail: boolean
        Allow approval from email

    ForceSecretApproval: string
        Require approval for secrets (None, RequireApprovalForOwnersAndEditors, RequireApprovalForEditors)

# METHODS

# RELATED LINKS:
    Get-TssConfiguration