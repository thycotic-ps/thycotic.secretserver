---
title: "AssociatedSecret"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Rpc.AssociatedSecret class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Rpc.AssociatedSecret

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Rpc.AssociatedSecret class represents the object returned by Secret Server endpoint GET /internals/secret-detail/{id}/rpc

# CONSTRUCTORS
    new()

# PROPERTIES
    ParentId: integer (int32)
        Secret ID of the Associated Secrets

    Order: integer (int32)
        Index order of the Associated Secrets

    Id: integer (int32)
        Associated Secret's ID

    Name: string
        Associated Secret's Name

    SecretTemplateName: string
        Associated Secret's Template Name

    FolderName: string
        Associated Secret's Folder Name

# METHODS

# RELATED LINKS:
    Get-TssSecretRpcAssociated