function Get-TssWorkflowTemplateAudit {
    <#
    .SYNOPSIS
    Get the audit records of a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Returns the audit records of the workflow template: action, user, date, notes and source machine.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssWorkflowTemplateAudit -TssSession $session -Id 4

    Get the audit records of workflow template 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WorkflowTemplateId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'workflows', 'templates', $currentId, 'audits' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssWorkflowTemplateAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.WorkflowTemplates.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.WorkflowTemplates.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
