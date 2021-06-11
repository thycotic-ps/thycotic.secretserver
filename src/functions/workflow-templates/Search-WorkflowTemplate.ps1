function Search-WorkflowTemplate {
    <#
    .SYNOPSIS
    Search Workflow Templates

    .DESCRIPTION
    Search Workflow Templates

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssWorkflowTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/workflows/Search-WorkflowTemplate.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssWorkflowTemplate -TssSession $session -IncludeInactive

    Search Workflow Templates and return those that are inactive in the results

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssWorkflowTemplateDetail')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Include inactive workflows
        [switch]
        $IncludeInactive,

        # Workflow Type, default to AccessRequest (only type available at this time)
        [Parameter()]
        [ValidateSet('AccessRequest')]
        [string]
        $Type = 'AccessRequest',

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'workflows', 'templates' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $uri = $uri, "filter.includeInactive=$([boolean]$IncludeInactive)", "filter.workflowType=$Type" -join '&'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No Workflow(s) found"
            }
            if ($restResponse.records) {
                [TssWorkflowTemplateDetail[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}