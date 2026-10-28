function Update-TssWorkflowTemplateStep {
    <#
    .SYNOPSIS
    Update a step of a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    The server replaces the whole step, so the cmdlet first reads the current step (Get-TssWorkflowTemplateStep -StepNumber) and changes only the parameters you pass; a failed read stops the cmdlet before any change.
    -GroupId and -OwnerReviewer replace the complete list of approvers; without them the current approvers are kept.
    -ApproveStep and -ExpireStep take 0 (none), -1 (next step), -2 (done) or the order of a later step.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER StepNumber
    Current order of the step in the template (1 for the first step)

    .PARAMETER Name
    New step name; must be unique in the template

    .PARAMETER Order
    New position of the step in the template, 1 to 15

    .PARAMETER ExpirationMinutes
    Minutes after which the step expires

    .PARAMETER NumApprovalsRequired
    Number of approvals the step needs

    .PARAMETER ApproveStep
    Step that follows an approval: 0 none, -1 next step, -2 done, or the order of a later step

    .PARAMETER ExpireStep
    Step that follows an expiration: 0 none, -1 next step, -2 done, or the order of a later step

    .PARAMETER GroupId
    IDs of the groups whose members can approve the step; replaces the current approvers

    .PARAMETER OwnerReviewer
    Make the secret owner an approver of the step; replaces the current approvers

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 1 -NumApprovalsRequired 2

    Require two approvals on the first step of workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 2 -GroupId 7, 8 -OwnerReviewer

    Make groups 7 and 8 and the secret owner the approvers of the second step of workflow template 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStep

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStep.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Step')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WorkflowTemplateId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $StepNumber,

        [string]
        $Name,

        [ValidateRange(1, 15)]
        [int]
        $Order,

        [int]
        $ExpirationMinutes,

        [ValidateRange(1, [int]::MaxValue)]
        [int]
        $NumApprovalsRequired,

        [int]
        $ApproveStep,

        [int]
        $ExpireStep,

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
            $current = Get-TssWorkflowTemplateStep -TssSession $TssSession -Id $Id -StepNumber $StepNumber -ErrorAction Stop
            if (-not $current) {
                Write-Error "Step [$StepNumber] of workflow template [$Id] could not be read; nothing was changed"
                return
            }
            $currentApprovers = @($current.Configuration.ApproverGroups)
            if ($tssParams.ContainsKey('GroupId') -or $OwnerReviewer) {
                $approvers = @(foreach ($group in $GroupId) {
                        $existing = $currentApprovers | Where-Object { $_.GroupId -eq $group -and -not $_.IsOwner } | Select-Object -First 1
                        @{ accessReviewerId = [int]$existing.AccessReviewerId; isUser = [boolean]$existing.IsUser; isOwner = $false; groupId = $group; workflowStepTemplateId = $current.WorkflowStepTemplateId; workflowTemplateId = $Id }
                    })
                if ($OwnerReviewer) {
                    $existing = $currentApprovers | Where-Object IsOwner | Select-Object -First 1
                    $approvers += @{ accessReviewerId = [int]$existing.AccessReviewerId; isUser = $false; isOwner = $true; workflowStepTemplateId = $current.WorkflowStepTemplateId; workflowTemplateId = $Id }
                }
            } else {
                $approvers = @(foreach ($approver in $currentApprovers) {
                        @{ accessReviewerId = $approver.AccessReviewerId; displayName = $approver.DisplayName; isUser = $approver.IsUser; isOwner = $approver.IsOwner; groupId = $approver.GroupId; workflowStepTemplateId = $approver.WorkflowStepTemplateId; workflowTemplateId = $approver.WorkflowTemplateId }
                    })
            }
            $body = @{
                workflowStepTemplateId = $current.WorkflowStepTemplateId
                name                   = $current.Name
                order                  = $current.Order
                expirationMinutes      = $current.ExpirationMinutes
                configuration          = @{
                    numApprovalsRequired = $current.Configuration.NumApprovalsRequired
                    approveStep          = $current.Configuration.ApproveStep
                    expireStep           = $current.Configuration.ExpireStep
                    approverGroups       = $approvers
                }
            }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.name = $Name
                }
                'Order' {
                    $body.order = $Order
                }
                'ExpirationMinutes' {
                    $body.expirationMinutes = $ExpirationMinutes
                }
                'NumApprovalsRequired' {
                    $body.configuration.numApprovalsRequired = $NumApprovalsRequired
                }
                'ApproveStep' {
                    $body.configuration.approveStep = $ApproveStep
                }
                'ExpireStep' {
                    $body.configuration.expireStep = $ExpireStep
                }
            }
            $uri = $TssSession.ApiUrl, 'workflows', 'templates', $Id, 'steps', $StepNumber -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Workflow template: $Id step: $StepNumber", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssWorkflowTemplateStep request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.WorkflowTemplates.Step](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.WorkflowTemplates.Step]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
