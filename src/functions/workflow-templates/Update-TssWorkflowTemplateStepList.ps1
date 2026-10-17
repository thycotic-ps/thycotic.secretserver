function Update-TssWorkflowTemplateStepList {
    <#
    .SYNOPSIS
    Replace all the steps of a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Sends the complete list of steps of the workflow template: a step with WorkflowStepTemplateId 0 is added, a step with an ID is updated, and an existing step that is not in the list is deleted.
    The cmdlet first reads the current steps (Get-TssWorkflowTemplateStep) and refuses to send a list that would delete steps unless -AllowDelete is passed; a failed read stops the cmdlet before any change.
    Step names must be unique, the Order of the steps must run 1, 2, 3 in list order, and every step needs at least one approver. Start from Get-TssWorkflowTemplateStep and Get-TssWorkflowTemplateStepStub output.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER Step
    Complete list of steps, in order

    .PARAMETER AllowDelete
    Allow the update to delete the existing steps that are not in -Step

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $steps = Get-TssWorkflowTemplateStep -TssSession $session -Id 4
    $steps[0].Configuration.NumApprovalsRequired = 2
    Update-TssWorkflowTemplateStepList -TssSession $session -Id 4 -Step $steps

    Require two approvals on the first step of workflow template 4 and keep the other steps

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $steps = @(Get-TssWorkflowTemplateStep -TssSession $session -Id 4)
    Update-TssWorkflowTemplateStepList -TssSession $session -Id 4 -Step $steps[0] -AllowDelete

    Keep only the first step of workflow template 4 and delete the others

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplateStepList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplateStepList.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Step[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('WorkflowTemplateId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Thycotic.PowerShell.WorkflowTemplates.Step[]]
        $Step,

        [switch]
        $AllowDelete
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $current = @(Get-TssWorkflowTemplateStep -TssSession $TssSession -Id $Id -ErrorAction Stop)
            $keptIds = @($Step | Where-Object { $_.WorkflowStepTemplateId -gt 0 } | ForEach-Object WorkflowStepTemplateId)
            $deleted = @($current | Where-Object { $_.WorkflowStepTemplateId -notin $keptIds })
            if ($deleted -and -not $AllowDelete) {
                Write-Error "The step list would delete steps [$(($deleted | ForEach-Object Name) -join ', ')] of workflow template [$Id]; pass -AllowDelete to delete them. Nothing was changed"
                return
            }
            $wireSteps = @(foreach ($item in $Step) {
                    @{
                        workflowStepTemplateId = $item.WorkflowStepTemplateId
                        workflowTemplateId     = $Id
                        name                   = $item.Name
                        order                  = $item.Order
                        expirationMinutes      = $item.ExpirationMinutes
                        configuration          = @{
                            numApprovalsRequired = $item.Configuration.NumApprovalsRequired
                            approveStep          = $item.Configuration.ApproveStep
                            expireStep           = $item.Configuration.ExpireStep
                            approverGroups       = @(foreach ($approver in $item.Configuration.ApproverGroups) {
                                    @{ accessReviewerId = $approver.AccessReviewerId; displayName = $approver.DisplayName; isUser = $approver.IsUser; isOwner = $approver.IsOwner; groupId = $approver.GroupId; workflowStepTemplateId = $item.WorkflowStepTemplateId; workflowTemplateId = $Id }
                                })
                        }
                    }
                })
            $uri = $TssSession.ApiUrl, 'workflows', 'templates', $Id, 'steps' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $invokeParams.Body = @{ workflowStepTemplates = $wireSteps } | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Workflow template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssWorkflowTemplateStepList request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.WorkflowTemplates.Step[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.WorkflowTemplates.Step]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
