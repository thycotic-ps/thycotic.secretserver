class TssWorkflowTemplateDetail {
    [boolean]
    $Active

    [string]
    $ConfigurationJson

    [string]
    $Description

    [int]
    $ExpirationMinutes

    [string]
    $Name

    [boolean]
    $Reusable

    [string]
    $TypeName

    [int]
    $WorkflowTemplateId

    [ValidateSet('AccessRequest')]
    [string]
    $WorkflowType
}