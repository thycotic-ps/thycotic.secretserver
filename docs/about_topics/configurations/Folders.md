---
title: "Folders"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.Folders class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.Folders

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.Folders class represents the ConfigurationFoldersModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    EnablePersonalFolders: boolean
        Each user will have a personal folder created and assigned to them

    PersonalFolderName: string
        The name of the root personal folder. Each user's personal folder will be named based on the user (DisplayName , UsernameAndDomain)

    PersonalFolderNameOption: string
        The format for the personal folder name for each user (DisplayName, UsernameAndDomain)

    PersonalFolderWarning: boolean
        Warning to be shown when creating Secrets if ShowPersonalFolderWarning is true

    RequireViewFolderPermission: boolean
        Users will only see folders they have View permissions on

    ShowPersonalFolderWarning: boolean
        When true the PersonalFolderWarning will be shown when creating Secrets

# METHODS

# RELATED LINKS:
    Get-TssConfiguration