---
title: "Request"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.AccessRequests.Request class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.AccessRequests.Request

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.AccessRequests.Request class represents the SecretAccessModel object returned by Secret Server endpoint GET /secret-access-requests/secrets/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    AccessRequestWorkflowMapId: integer (int32)
        The Id of the Access Request Workflow Map.

    ApproverDisplayName: string
        The Display Name of the Approver of the request

    Completed: boolean
        Indicating if request has been completed

    CurrentUserRestrictedFromReviewing: boolean
        Indicating if current user is restricted from viewing the request

    ExpirationDate: string (date-time)
        The Expiration Date of the request

    FolderId: integer (int32)
        The Folder Id of the Secret associated to the access request.

    HasWorkflow: boolean
        Indicating if request is associated to a Work Flow

    RequestComment: string
        The Comment of the request.

    RequestDate: string (date-time)
        The Date of the request.

    RequestingUserId: integer (int32)
        The Id of the User requesting access.

    RequestUsername: string
        The Username of the User requesting access.

    ResponseComment: string
        The Comment of the response to the request

    ResponseDate: string (date-time)
        The Date of the response to the request

    ReviewStatusMessage: string
        The Review Status Message of the request

    SecretAccessRequestId: integer (int32)
        The Id of the Secret Access Request.

    SecretId: integer (int32)
        The Id of the Secret associated to the access request.

    SecretName: string
        The Name of the Secret associated to the access request.

    StartDate: string (date-time)
        The Start Date of the request.

    Status: string
        The Status of the request, ("WaitingForRequest" "Pending" "Approved" "Denied" "Canceled" "Expired")

    StatusDescription: string
        The Status Description of the request

    TicketNumber: string
        The Ticket Number of the request

    TicketSystemId: integer (int32)
        The Ticket System Id of the request

# METHODS

# RELATED LINKS:
    Get-TssSecretAccessRequestSecret