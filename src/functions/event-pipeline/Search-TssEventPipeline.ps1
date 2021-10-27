function Search-TssEventPipeline {
    <#
    .SYNOPSIS
    Get a list of Event Pipeline Policies

    .DESCRIPTION
    Get a list of Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipeline -TssSession $session

    Return a list of all active Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipeline -TssSession $session -IncludeInactive

    Return a list of all active and inactive Event Pipeline Policies

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Search-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline Policy ID
        [int]
        $PipelinePolicyId,

        # Event Pipeline Name
        [string]
        $PipelineName,

        # Event Entity Type
        [ValidateSet('Secret','User')]
        [Thycotic.PowerShell.Enums.EventEntityType]
        $EventEntityType,

        # Include inactive policies
        [switch]
        $IncludeInactive,

        # Exclude Active policies
        [switch]
        $ExcludeActive,

        # Sort by specific property, default EventPipelineName
        [string]
        $SortBy = 'EventPipelineName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline', 'summaries' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'PipelineId' { $filters += "filter.eventPipelineId=$PipelineId" }
                'PipelineName' { $filters += "filter.eventPipelineName=$PipelineName" }
                'EventEntityType' { $filters += "filter.eventEntityTypeId=$EventEntityType"}
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

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting list of Event Pipeline"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.EventPipeline.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}