---
category: rpc
title: "TssSecretRpcAssociated"
last_modified_at: 2021-04-14T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecretRpcAssociated class in the Thycotic.SecretServer module

# CLASS
    TssSecretRpcAssociated

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretRpcAssociated class represents the resetSecrets object returned by Secret Server endpoint GET /internals/secret-detail/{id}/rpc

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