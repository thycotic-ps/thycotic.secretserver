function Search-TssDistributedEngineSite {
    <#
    .SYNOPSIS
    Search Distributed Engine Sites in Secret Server

    .DESCRIPTION
    Search Distributed Engine Sites in Secret Server

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineSite.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngineSite -TssSession $session - some test value

    Add minimum example for each parameter

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site Id
        [int]
        $SiteId,

        # Site Name
        [string]
        $SiteName,

        # Include Site Metrics (e.g. how many inactive or active sites)
        [switch]
        $IncludeSiteMetrics,

        # Include Sites that can have new engines added
        [switch]
        $IncludeSitesAddNewEngines,

        # Include inactive sites
        [switch]
        $IncludeInactive,

        # Sort by specific property, default SiteName
        [string]
        $SortBy = 'SiteName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'sites' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

            $filters = @()
            switch ($tssParams.Keys) {
                'SiteId' { $filters += "filter.siteId=$SiteId" }
                'SiteName' { $filters += "filter.siteName=$SiteName" }
                'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                'IncludeSiteMetrics' { $filters += "filter.includeSiteMetrics=$([boolean]$IncludeSiteMetrics)" }
                'IncludeSitesAddNewEngines' { $filters += "filter.onlyIncludeSitesThatCanAddNewEngines=$([boolean]$IncludeSitesAddNewEngines)" }
                default {
                    $filters += 'filter.includeInactive=false'
                    $filters += 'filter.includeSiteMetrics=false'
                    $filters += 'filter.onlyIncludeSitesThatCanAddNewEngines=false'
                }
            }

            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: $body"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No Distributed Engine Sites found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DistributedEngines.SiteSummary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}