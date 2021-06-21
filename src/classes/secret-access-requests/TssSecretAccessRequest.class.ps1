class TssSecretAccessRequest {
    [int]
    $AccessRequestWorkflowMapId

    [string]
    $ApproverDisplayName

    [boolean]
    $Completed

    [boolean]
    $CurrentUserRestrictedFromReviewing

    [Nullable[datetime]]
    $ExpirationDate

    [int]
    $FolderId

    [boolean]
    $HasWorkflow

    [string]
    $RequestComment

    [Nullable[datetime]]
    $RequestDate

    [int]
    $RequestingUserId

    [string]
    $RequestUsername

    [string]
    $ResponseComment

    [Nullable[datetime]]
    $ResponseDate

    [string]
    $ReviewStatusMessage

    [int]
    $SecretAccessRequestId

    [int]
    $SecretId

    [string]
    $SecretName

    [Nullable[datetime]]
    $StartDate

    [ValidateSet('WaitingForRequest','Pending','Approved','Denied','Canceled','Expired')]
    [string]
    $Status

    [string]
    $StatusDescription

    [string]
    $TicketNumber

    [int]
    $TicketSystemId
}