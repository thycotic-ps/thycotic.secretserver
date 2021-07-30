TOPIC
    This help topic describes the Thycotic.PowerShell.EventPipelinePolicy.List class in the Thycotic.SecretServer module

CLASS
    Thycotic.PowerShell.EventPipelinePolicy.List

INHERITANCE
    None

DESCRIPTION
    The Thycotic.PowerShell.EventPipelinePolicy.List class represents the object returned by Secret Server endpoint GET /event-pipeline-policy/list

CONSTRUCTORS
    new()

PROPERTIES
    Active boolean
        Active

    CreatedDate string <date-time>
        Created Date

    EventEntityTypeId integer <int32>
        Event Entity Type ID

    EventPipelinePolicyDescription string
        Event Pipeline Policy Description

    EventPipelinePolicyId integer <int32>
        Event Pipeline Policy ID

    EventPipelinePolicyName string
        Event Pipeline Policy Name

    IsSystem boolean
        Is System

    LastModifiedDate string <date-time>
        Last Modified Date

    LastModifiedDisplayName string
        Last Modified Display Name

METHODS

RELATED LINKS:
    Get-TssEventPipelineList