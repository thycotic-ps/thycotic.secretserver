---
title: "TssFolderDetailView"
---

# TOPIC
    This help topic describes the TssFolderDetailView class in the Thycotic.SecretServer module

# CLASS
    TssFolderDetailView

# INHERITANCE
    None

# DESCRIPTION
    The TssFolderDetailView class represents the FolderDetailViewModel object returned by Secret Server endpoint GET /folder-details/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    Actions: string[]
        Actions. (CreateSubfolder , EditFolder , AddSecret , DeleteFolder , MoveFolder)

    AllowedTemplates: TssFolderDetailTemplateView[]
        AllowedTemplates

    FolderWarning: string
        FolderWarning

    Id: integer (int32)
        Id

    Name: string
        Name

# METHODS
    [System.String[]] GetActions()
        Returns the Actions, sorted

    [System.Boolean] TestAction([string]Action)
        Returns true if action exist, false if not

# RELATED LINKS:
    Get-TssFolderState