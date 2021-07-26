---
title: "Lookup"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.Lookup class in the Thycotic.SecretServer module.

# CLASS
    Thycotic.PowerShell.Secrets.Lookup

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.Lookup class represents a revised version of the SecretLookup object returned by Secret Server endpoint /secrets/lookup.
    This endpoint returns records as ID and Value:
        "id": <secret id>
        "value: "<Folder ID> - <Secret Template ID> - <Secret Name>
    This class is revising this to output the items in the value as proper properties (handled by the calling function).

# CONSTRUCTORS
    new()

# PROPERTIES
    SecretId:
        ID of the secret

    FolderId:
        Folder ID of the secret

    SecretTemplateId:
        Secret Template ID of the secret

    SecretName:
        Secret name

# METHODS

# RELATED LINKS:
    Find-TssSecret