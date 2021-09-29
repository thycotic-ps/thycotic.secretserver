function Search-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Get a list of Event Pipeline Policies

    .DESCRIPTION
    Get a list of Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelinePolicy -TssSession $session

    Return a list of all active Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelinePolicy -TssSession $session -IncludeInactive

    Return a list of all active and inactive Event Pipeline Policies

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Search-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.List')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline ID
        [int]
        $PipelineId,

        # Event Pipeline Policy Name
        [string]
        $PolicyName,

        # Folder ID (target of policy)
        [int]
        $FolderId,

        # Include inactive policies
        [switch]
        $IncludeInactive,

        # Exclude Active policies
        [switch]
        $ExcludeActive,

        # Sort by specific property, default EventPipelinePolicyName
        [string]
        $SortBy = 'EventPipelinePolicyName'
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'list' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'PipelineId' { $filters += "filter.eventPipelineId=$PipelineId" }
                'PolicyName' {$fiters += "filter.eventPipelinePolicyName=$PolicyName"}
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                'ExcludeActive' { $filters += "filter.includeActive=$([boolean]$ExcludeActive)" }
                'FolderId' { $filters += "filter.folderId=$FolderId" }
            }

            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting list of Event Pipeline Policies"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.EventPipelinePolicy.List[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}