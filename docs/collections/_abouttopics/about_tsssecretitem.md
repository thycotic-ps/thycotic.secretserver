---
category: secrets
title: "TssSecretItem"
last_modified_at: 2021-02-15T00:00:00-00:00
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
    Documented in the REST API doc for Secret Server, see RestSecretItem definition

# METHODS

    [boolean] SetFieldValue([slug]Slug, Value)
        Set the ItemValue for the current item record, filtered by Slug

# RELATED LINKS:
    Get-TssSecret
    Get-TssSecretStub
    New-TssSecret