---
title: "Field"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretTemplates.Field class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretTemplates.Field

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretTemplates.Field class represents the ISecretTemplateField object that is part of the SecretTemplateModel returned by endpoint '/secret-template/{id}'

# CONSTRUCTORS
    new()

# PROPERTIES
    Description
        Description

    DisplayName
        Display Name

    EditablePermission
        Editable Permission (-1 = NotEditable, 2 = Edit, 3 = Owner)

    EditRequires
        Edit Requires (Edit, Owner, NotEditable)

    FieldSlugName
        Field Slug Name

    GeneratePasswordCharacterSet
        Generate Password Character Set

    GeneratePasswordLength
        Generate Password Length

    HideOnView
        Hide On View

    HistoryLength
        History Length

    IsExpirationField
        IsExpirationField

    IsFile
        IsFile

    IsIndexable
        IsIndexable

    IsNotes
        IsNotes

    IsPassword
        IsPassword

    IsRequired
        IsRequired

    IsUrl
        IsUrl

    IsList
        IsList

    ListType
        List Type (None, Generic, URL)

    MustEncrypt
        MustEncrypt (Expose for Display)

    Name
        Name

    PasswordRequirementId
        PasswordRequirementId

    PasswordTypeFieldId
        PasswordTypeFieldId

    SecretTemplateFieldId
        SecretTemplateFieldId

    SortOrder
        Sort Order

# METHODS

# RELATED LINKS:
    Get-TssSecretTemplate