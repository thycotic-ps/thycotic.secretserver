function Get-TssEventPipelineList {
    <#
    .SYNOPSIS
    Get a list of Event Pipeline Policies

    .DESCRIPTION
    Get a list of Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineList -TssSession $session

    Return a list of all active Event Pipeline Policies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineList -TssSession $session -IncludeInactive

    Return a list of all active and inactive Event Pipeline Policies

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Get-TssEventPipelineList

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelineList.ps1

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

        # Folder ID (target of policy)
        [int]
        $FolderId,

        # Include inactive policies
        [switch]
        $IncludeInactive,

        # Sort by specific property, default EventPipelinePolicyName
        [string]
        $SortBy = 'EventPipelinePolicyName'
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'list' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
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
                $restResponse = . $InvokeApi @invokeParams
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