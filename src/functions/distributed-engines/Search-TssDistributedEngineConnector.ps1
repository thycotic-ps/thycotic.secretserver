function Search-TssDistributedEngineConnector {
    <#
    .SYNOPSIS
    Search list of Site Connectors for Distributed Engine

    .DESCRIPTION
    Search list of Site Connectors for Distributed Engine

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineConnector.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineConnector -TssSession $session

    Return list of active Site Connectors

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineConnector -TssSession $session -IncludeInactive

    Return list of Site Connectors, including those inactive

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteConnectorSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Include inactive Site Connectors
        [switch]
        $IncludeInactive,

        # Sort by specific property, default SiteConnectorId
        [string]
        $SortBy = 'SiteConnectorId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connectors' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInActive)" }
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
                [Thycotic.PowerShell.DistributedEngines.SiteConnectorSummary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}