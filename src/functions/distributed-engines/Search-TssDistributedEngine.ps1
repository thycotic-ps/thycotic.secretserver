function Search-TssDistributedEngine {
    <#
    .SYNOPSIS
    Search Distributed Engines

    .DESCRIPTION
    Search Distributed Engines

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngine.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngine -TssSession $session -SiteId 1

    Return list of engines assigned to Site ID 1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site ID
        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $SiteId,

        # Only return engines with this activation status
        [Thycotic.PowerShell.Enums.EngineActivationStatus]
        $ActivationStatus,

        # Only return engines with this connection status
        [Thycotic.PowerShell.Enums.EngineConnectionStatus]
        $ConnectionStatus,

        # Only return engines with a friendly name that contains this text
        [string]
        $SearchText,

        # Only include engines that require action. For example, pending but not deleted or no site assigned.
        [switch]
        $RequireActivation,

        # Sort by specific property, default EngineId
        [string]
        $SortBy = 'EngineId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'engines' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'SiteId' { $filters += "filter.siteId=$SiteId" }
                'ActivationStatus' { $filters += "filter.activationStatus = $([string]$ActivationStatus)" }
                'ConnectionStatus' { filters += "filter.connectionStatus = $([string]$ConnectionStatus)" }
                'SearchText' { $filters += "filter.friendlyName = $SearchText" }
                'RequireActivation' { $filters += "filter.onlyIncludeRequiringAction=$([boolean]$RequireActivation)" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

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
                Write-Warning "No records found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DistributedEngines.EngineSummary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}