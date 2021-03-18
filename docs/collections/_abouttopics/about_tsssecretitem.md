---
category: secrets
title: "TssSecretItem"
last_modified_at: 2021-03-17T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecret class in the Thycotic.SecretServer module.

# CLASS
    TssSecretItem

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretItem class represents the RestSecretItem object of a secret returned by Secret Server endpoint /secrets{id}.

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
    Get-TssSecret
    Get-TssSecretStub
    New-TssSecret