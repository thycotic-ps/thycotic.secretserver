function New-TssWorkflowTemplateStep {
    <#
    .SYNOPSIS
    Add a step to a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Adds an approval step to the workflow template and returns the new step ID. The step needs at least one approver: groups (-GroupId), the secret owner (-OwnerReviewer), or both.
    The step name must be unique in the template and -Order (1 to 15) must not be used by another step. Without an owner approver, -NumApprovalsRequired cannot exceed the number of active users in the groups.
    -ApproveStep and -ExpireStep take 0 (none), -1 (next step), -2 (done) or the order of a later step.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER Name
    Step name; must be unique in the template

    .PARAMETER Order
    Position of the step in the template, 1 to 15

    .PARAMETER NumApprovalsRequired
    Number of approvals the step needs; default 1

    .PARAMETER ApproveStep
    Step that follows an approval: 0 none, -1 next step (default), -2 done, or the order of a later step

    .PARAMETER ExpireStep
    Step that follows an expiration: 0 none (default), -1 next step, -2 done, or the order of a later step

    .PARAMETER GroupId
    IDs of the groups whose members can approve the step

    .PARAMETER OwnerReviewer
    Add the secret owner as an approver of the step

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssWorkflowTemplateStep -TssSession $session -Id 4 -Name 'Security review' -Order 2 -GroupId 7

    Add a second step to workflow template 4, approved by a member of group 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssWorkflowTemplateStep -TssSession $session -Id 4 -Name 'Owner sign-off' -Order 3 -ApproveStep -2 -OwnerReviewer

    Add a final step to workflow template 4 that the secret owner approves

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplateStep

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplateStep.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Int32')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WorkflowTemplateId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [ValidateRange(1, 15)]
        [int]
        $Order,

        [ValidateRange(1, [int]::MaxValue)]
        [int]
        $NumApprovalsRequired = 1,

        [int]
        $ApproveStep = -1,

        [int]
        $ExpireStep = 0,

        [int[]]
        $GroupId,

        [switch]
        $OwnerReviewer
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $approvers = @(foreach ($group in $GroupId) {
                    @{ accessReviewerId = 0; isUser = $false; isOwner = $false; groupId = $group; workflowStepTemplateId = 0; workflowTemplateId = $Id }
                })
            if ($OwnerReviewer) {
                $approvers += @{ accessReviewerId = 0; isUser = $false; isOwner = $true; workflowStepTemplateId = 0; workflowTemplateId = $Id }
            }
            if ($approvers.Count -eq 0) {
                Write-Error 'A workflow step needs at least one approver: pass -GroupId, -OwnerReviewer or both'
                return
            }
            $uri = $TssSession.ApiUrl, 'workflows', 'templates', $Id, 'steps' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                workflowTemplateId = $Id
                name               = $Name
                order              = $Order
                configuration      = @{
                    numApprovalsRequired = $NumApprovalsRequired
                    approveStep          = $ApproveStep
                    expireStep           = $ExpireStep
                    approverGroups       = $approvers
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Workflow template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssWorkflowTemplateStep request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [int]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
