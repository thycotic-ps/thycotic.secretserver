function Update-TssWorkflowTemplate {
    <#
    .SYNOPSIS
    Update a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Updates the name, description, active state or configuration of a workflow template. Only the parameters you pass are changed.
    Deactivating a template records the deactivation date. The type and the expiration are set when the template is created and cannot be changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER Active
    Activate the template; -Active:$false deactivates it

    .PARAMETER ConfigurationJson
    New configuration, as JSON

    .PARAMETER Description
    New description

    .PARAMETER Name
    New name; must be unique

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssWorkflowTemplate -TssSession $session -Id 4 -Description 'Two approvals for production secrets'

    Change the description of workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssWorkflowTemplate -TssSession $session -Id 4 -Active

    Activate workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssWorkflowTemplate -TssSession $session -Id 4 -Active:$false

    Deactivate workflow template 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Update-TssWorkflowTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Update-TssWorkflowTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Detail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WorkflowTemplateId')]
        [int]
        $Id,

        [switch]
        $Active,

        [string]
        $ConfigurationJson,

        [string]
        $Description,

        [string]
        $Name
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'workflows', 'templates', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'ConfigurationJson' {
                    $body.Add('configurationJson', @{ dirty = $true; value = $ConfigurationJson })
                }
                'Description' {
                    $body.Add('description', @{ dirty = $true; value = $Description })
                }
                'Name' {
                    $body.Add('name', @{ dirty = $true; value = $Name })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Workflow template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssWorkflowTemplate request'
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
