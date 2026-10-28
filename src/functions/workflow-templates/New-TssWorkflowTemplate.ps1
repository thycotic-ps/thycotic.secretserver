function New-TssWorkflowTemplate {
    <#
    .SYNOPSIS
    Create a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Creates a workflow template and returns its ID. Secret Server creates the template inactive, with a first step that has no approvers; give it approvers with Update-TssWorkflowTemplateStep -StepNumber 1 -GroupId, add steps with New-TssWorkflowTemplateStep, then activate the template with Update-TssWorkflowTemplate -Active.
    Workflow templates cannot be deleted; deactivate one with Update-TssWorkflowTemplate -Active:$false.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Template name; must be unique

    .PARAMETER Type
    Workflow type: AccessRequest (default) or SecretEraseRequest

    .PARAMETER Description
    Template description

    .PARAMETER ExpirationMinutes
    Minutes after which a request that runs through the template expires

    .PARAMETER ConfigurationJson
    Template configuration, as JSON

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssWorkflowTemplate -TssSession $session -Name 'Production access' -Description 'Two approvals for production secrets'

    Create an access request workflow template and return its ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $id = New-TssWorkflowTemplate -TssSession $session -Name 'Erase review' -Type SecretEraseRequest
    Get-TssWorkflowTemplate -TssSession $session -Id $id

    Create a secret erase request workflow template and get it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/New-TssWorkflowTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/New-TssWorkflowTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Int32')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Thycotic.PowerShell.Enums.WorkflowTypes]
        $Type = 'AccessRequest',

        [string]
        $Description,

        [int]
        $ExpirationMinutes,

        [string]
        $ConfigurationJson
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'workflows', 'templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                name         = $Name
                workflowType = [string]$Type
            }
            switch ($tssParams.Keys) {
                'Description' {
                    $body.Add('description', $Description)
                }
                'ExpirationMinutes' {
                    $body.Add('expirationMinutes', $ExpirationMinutes)
                }
                'ConfigurationJson' {
                    $body.Add('configurationJson', $ConfigurationJson)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Workflow template: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssWorkflowTemplate request'
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
