function Get-TssWorkflowTemplateEntityCount {
    <#
    .SYNOPSIS
    Get the number of items that use a workflow template

    .DESCRIPTION
    Workflow templates define the approval steps of secret access requests and secret erase requests. Managing them requires the Administer Workflows permission and a Secret Workflow license.
    Returns the number of secrets and folders that use the workflow template, as an integer. The items themselves are not listed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Workflow template ID

    .PARAMETER IncludeAll
    Count every item that uses the template, not only the active ones

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssWorkflowTemplateEntityCount -TssSession $session -Id 4

    Count the active items that use workflow template 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssWorkflowTemplate -TssSession $session | ForEach-Object { [pscustomobject]@{ Name = $_.Name; Count = (Get-TssWorkflowTemplateEntityCount -TssSession $session -Id $_.WorkflowTemplateId -IncludeAll) } }

    List every active workflow template with the number of items that use it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflow-templates/Get-TssWorkflowTemplateEntityCount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflow-templates/Get-TssWorkflowTemplateEntityCount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Int32')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WorkflowTemplateId')]
        [int[]]
        $Id,

        [switch]
        $IncludeAll
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $includeAllSegment = ([boolean]$IncludeAll).ToString().ToLowerInvariant()
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'workflows', 'templates', $currentId, 'entities', $includeAllSegment -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssWorkflowTemplateEntityCount request'
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
