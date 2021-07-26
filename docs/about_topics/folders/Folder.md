---
title: "Folder"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Folders.Folder class in the Thycotic.SecretServer module.

# CLASS
    Thycotic.PowerShell.Folders.Folder

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Folders.Folder class represents the FolderModel object returned by Secret Server endpoint /folders/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    ChildFolders Folder[]
        List of folders within this folder

    FolderName
        Folder name

    FolderPath
        Path of this folder

    FolderTypeId
        Folder type ID

    Id
        Folder ID

    InheritPermissions
        Whether the folder inherits permissions from its parent

    InheritSecretPolicy
        Whether the folder inherits the secret policy

    ParentFolderId
        Parent folder ID

    SecretPolicyId
        Secret policy ID

    SecretTemplates FolderTemplate[]
        List of templates that may be used to create secrets in this folder

# METHODS

# RELATED LINKS:
    Get-TssFolder