---
category: secrets
title: "TssSecret"
last_modified_at: 2021-02-10T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecret class in the Thycotic.SecretServer module.

# CLASS
    TssSecret

# INHERITANCE
    None

# DESCRIPTION
    The TssSecret class represents the SecretModel object returned by Secret Server endpoint /secrets{id}.

# CONSTRUCTORS
    new()

# PROPERTIES
    Documented in the REST API doc for Secret Server, see SecretModel definition

# METHODS

    [PSCredential] GetCredential()
        Pulls the username field and the field flagged as the password (IsPassword = true)
        Creates and will output a System.Management.Automation.PSCredential object

    [System.String] GetFieldValue(string Slug)
        Pulls the ItemValue of the field based on the slug name

    [Boolean] SetFieldValue(string Slug, Value)
        Sets the ItemValue value of a Field item

# RELATED LINKS:
    Get-TssSecret
    Get-TssSecretStub
    New-TssSecret