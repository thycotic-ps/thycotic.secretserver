function Search-TssWorkflowTemplate {
    <#
    .SYNOPSIS
    Search Workflow Templates

    .DESCRIPTION
    Search Workflow Templates

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/workflows/Search-TssWorkflowTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-TssWorkflowTemplate.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssWorkflowTemplate -TssSession $session -IncludeInactive

    Search Workflow Templates and return those that are inactive in the results

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.WorkflowTemplates.Detail')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Include inactive workflows
        [switch]
        $IncludeInactive,

        # Workflow Type (AccessRequest, SecretEraseRequest)
        [Thycotic.PowerShell.Enums.WorkflowTypes]
        $Type,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'workflows', 'templates' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $uri = $uri, "filter.includeInactive=$([boolean]$IncludeInactive)" -join '&'

            if ($tssParams.ContainsKey('Type')) {
                $uri = $uri, "filter.workflowType=$([string]$Type)" -join '&'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No Workflow(s) found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.WorkflowTemplates.Detail[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}