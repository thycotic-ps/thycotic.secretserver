---
title: "Template"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretTemplates.Template class in the Thycotic.SecretServer module.

# CLASS
    Thycotic.PowerShell.SecretTemplates.Template

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretTemplates.Template class represents the SecretTemplateModel object returned by Secret Server endpoint /secret-templates/{id}.

# CONSTRUCTORS
    new()

# PROPERTIES
    Id
        Secret Template Id

    Name
        Secret Template name

    PasswordTypeId
        Password Type ID

    Fields Field[]

# METHODS

    [System.String] GetSlugName([string] FieldName)
        Gets the FieldSlugName value from the Fields property if the FieldName provided equals a FieldSlugName

    [Field] GetField(string SlugName)
        Gets the Field object from Fields property if the SlugName provided equals a FieldSlugName value.

# RELATED LINKS:
    Get-TssSecretTemplate