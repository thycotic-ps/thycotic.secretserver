---
category: secrets
title: "TssSecretLookup"
last_modified_at: 2021-02-10T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecretLookup class in the Thycotic.SecretServer module.

# CLASS
    TssSecretLookup

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretLookup class represents a revised version of the SecretLookup object returned by Secret Server endpoint /secrets/lookup.
    This endpoint returns records as ID and Value:
        "id": <secret id>
        "value: "<Folder ID> - <Secret Tempalte ID> - <Secret Name>
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