---
title: "DetailView"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Folders.DetailView class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Folders.View

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Folders.DetailView class represents the FolderDetailViewModel object returned by Secret Server endpoint GET /folder-details/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    Actions: string[]
        Actions. (CreateSubfolder , EditFolder , AddSecret , DeleteFolder , MoveFolder)

    AllowedTemplates: DetailTemplateView[]
        AllowedTemplates

    FolderWarning: string
        FolderWarning

    Id: integer (int32)
        Id

    Name: string
        Name

# METHODS

# RELATED LINKS:
    Get-TssFolderState