class TssSiteSummary {
    [boolean]
    $Active

    [boolean]
    $IsLocal

    [datetime]
    $LastActivity

    [int]
    $NumEnginesMissingNetFramework

    [int]
    $OfflineEngineCount

    [int]
    $OnlineEngineCount

    [int]
    $SiteId

    [TssSiteMetrics[]]
    $SiteMetrics

    [string]
    $SiteName
}