---
title: "Summary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretTemplates.Summary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretTemplates.Summary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretTemplates.Summary class represents the SecretTemplateSummary object returned by Secret Server endpoint GET /secret-templates

# CONSTRUCTORS
    new()

# PROPERTIES
    Active
        Is Secret template active

    Id
        Secret template ID

    Name
        Secret template name

    SecretCount
        Number of Secrets associated to the template. Only populated when IncludeSecretCount is provided.

# METHODS

# RELATED LINKS:
    Search-TssSecretTemplate