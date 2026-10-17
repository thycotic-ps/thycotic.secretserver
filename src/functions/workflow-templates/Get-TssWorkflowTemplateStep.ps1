function Get-TssWorkflowTemplateStep {
    <#
    .SYNOPSIS
    Get the steps of a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Returns every step of the workflow template, or one step with -StepNumber. Each step carries its approvers, the number of approvals required and the steps that follow an approval or an expiration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER StepNumber
    Order of the step in the template (1 for the first step); returns only that step

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssWorkflowTemplateStep -TssSession $session -Id 4

    Get every step of workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssWorkflowTemplateStep -TssSession $session -Id 4 -StepNumber 2).Configuration.ApproverGroups

    List the approvers of the second step of workflow template 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateStep

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateStep.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Step')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Single')]
        [Alias('WorkflowTemplateId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [int]
        $StepNumber
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                switch ($PSCmdlet.ParameterSetName) {
                    'Single' {
                        $uri = $TssSession.ApiUrl, 'workflows', 'templates', $currentId, 'steps', $StepNumber -join '/'
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'workflows', 'templates', $currentId, 'steps' -join '/'
                        $uri = $uri, "take=$($TssSession.Take)" -join '?'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssWorkflowTemplateStep request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($PSCmdlet.ParameterSetName -eq 'Single') {
                    if ($restResponse) {
                        [Thycotic.PowerShell.WorkflowTemplates.Step](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.WorkflowTemplates.Step]))
                    }
                } elseif ($restResponse.records) {
                    [Thycotic.PowerShell.WorkflowTemplates.Step[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.WorkflowTemplates.Step]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
