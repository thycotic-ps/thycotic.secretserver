---
title: "Thycotic.PowerShell.Secrets.Items"
---

# TOPIC
    This help topic describes the TssSecret class in the Thycotic.SecretServer module.

# CLASS
    Thycotic.PowerShell.Secrets.Items

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.Items class represents the RestSecretItem object of a secret returned by Secret Server endpoint /secrets{id}.

# CONSTRUCTORS
    new()

# PROPERTIES
    FieldDescription
        Field description

    FieldId
        Field ID

    FieldName
        Field name

    FileAttachmentId
        File attachment ID (used for file attachments)

    Filename
        File name (used for file attachments)

    IsFile
        Whether the field is a file attachment

    IsNotes
        Whether the field is notes

    IsPassword
        Whether the field is a password

    ItemId
        Item ID

    ItemValue
        Item value

    Slug
        Field Name Slug

# METHODS

# RELATED LINKS:
    Thycotic.PowerShell.Secrets.Secret
    Get-TssSecret
    Get-TssSecretStub
    New-TssSecret