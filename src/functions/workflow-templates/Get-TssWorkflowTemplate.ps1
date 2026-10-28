function Get-TssWorkflowTemplate {
    <#
    .SYNOPSIS
    Get a workflow template by ID

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Returns the workflow template with its type, configuration and state.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssWorkflowTemplate -TssSession $session -Id 4

    Get workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssWorkflowTemplate -TssSession $session -IncludeInactive | Get-TssWorkflowTemplate -TssSession $session

    Get every workflow template, active and inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Detail')]
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
                $uri = $TssSession.ApiUrl, 'workflows', 'templates', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssWorkflowTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.WorkflowTemplates.Detail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.WorkflowTemplates.Detail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
