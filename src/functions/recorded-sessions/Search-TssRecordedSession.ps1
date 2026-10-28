function Search-TssRecordedSession {
    <#
    .SYNOPSIS
    Search recorded sessions

    .DESCRIPTION
    Search the recorded sessions shown on the Session Monitoring page, filtered by text, status, date, folder, secret, user, group, site or launcher type.
    Secret Server needs at least one search type; when SearchTypes is not given, SecretItems, Username, Hostname and Domain are searched.
    DateRange wins over StartDate and EndDate. StartDate and EndDate apply only when both are given; StartTime and EndTime apply only when both dates and both times are given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Return only active sessions; -Active:$false returns only ended sessions

    .PARAMETER DateRange
    Return sessions from the last number of days

    .PARAMETER EndDate
    Return sessions up to this date (used only together with StartDate)

    .PARAMETER EndTime
    Time of day on EndDate, for example 17:30 (used only together with StartTime)

    .PARAMETER ExcludedApplications
    Application names to leave out of the results

    .PARAMETER FolderId
    Return sessions of secrets in this folder

    .PARAMETER GroupIds
    Return sessions of the users in these groups

    .PARAMETER HasError
    Return only sessions with a processing error; -HasError:$false returns only sessions without one

    .PARAMETER IncludeNonSecretServerSessions
    Include sessions that were not launched from a secret

    .PARAMETER IncludeOnlyLaunchedSuccessfully
    Return only sessions that launched successfully

    .PARAMETER IncludeRestricted
    Include sessions of restricted secrets

    .PARAMETER IncludeSubFolders
    Include sessions of secrets in subfolders of FolderId

    .PARAMETER LauncherTypeId
    Return sessions of this launcher type

    .PARAMETER SearchText
    Text to search for across the search types

    .PARAMETER SearchTypes
    Sources to search across: SecretName, SecretItems, Username, Hostname, Domain, RdpKeystroke, RdpApplication, ProxyClient (default SecretItems, Username, Hostname, Domain)

    .PARAMETER SecretIds
    Return sessions of these secrets

    .PARAMETER SiteId
    Return sessions run through this site

    .PARAMETER StartDate
    Return sessions from this date (used only together with EndDate)

    .PARAMETER StartTime
    Time of day on StartDate, for example 08:00 (used only together with EndTime)

    .PARAMETER UserIds
    Return sessions of these users

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRecordedSession -TssSession $session -DateRange 7

    Get the recorded sessions of the last 7 days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRecordedSession -TssSession $session -SearchText web01 -SearchTypes Hostname -Active

    Get the active sessions on hosts matching web01

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRecordedSession -TssSession $session -SecretIds 42 -StartDate 2026-01-01 -EndDate 2026-01-31

    Get the sessions of secret 42 in January 2026

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Search-TssRecordedSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Search-TssRecordedSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.RecordedSessionItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [int]
        $DateRange,

        [datetime]
        $EndDate,

        [string]
        $EndTime,

        [string[]]
        $ExcludedApplications,

        [int]
        $FolderId,

        [int[]]
        $GroupIds,

        [switch]
        $HasError,

        [switch]
        $IncludeNonSecretServerSessions,

        [switch]
        $IncludeOnlyLaunchedSuccessfully,

        [switch]
        $IncludeRestricted,

        [switch]
        $IncludeSubFolders,

        [int]
        $LauncherTypeId,

        [string]
        $SearchText,

        [ValidateSet('SecretName', 'SecretItems', 'Username', 'Hostname', 'Domain', 'RdpKeystroke', 'RdpApplication', 'ProxyClient')]
        [string[]]
        $SearchTypes = @('SecretItems', 'Username', 'Hostname', 'Domain'),

        [int[]]
        $SecretIds,

        [int]
        $SiteId,

        [datetime]
        $StartDate,

        [string]
        $StartTime,

        [int[]]
        $UserIds
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'recorded-sessions' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Active' {
                    $queryParams += "filter.active=$([boolean]$Active)"
                }
                'DateRange' {
                    $queryParams += "filter.dateRange=$($DateRange)"
                }
                'EndDate' {
                    $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                }
                'EndTime' {
                    $queryParams += "filter.endTime=$([uri]::EscapeDataString($EndTime))"
                }
                'ExcludedApplications' {
                    foreach ($queryValue in $ExcludedApplications) {
                        $queryParams += "filter.excludedApplications=$([uri]::EscapeDataString($queryValue))"
                    }
                }
                'FolderId' {
                    $queryParams += "filter.folderId=$($FolderId)"
                }
                'GroupIds' {
                    foreach ($queryValue in $GroupIds) {
                        $queryParams += "filter.groupIds=$($queryValue)"
                    }
                }
                'HasError' {
                    $queryParams += "filter.hasError=$([boolean]$HasError)"
                }
                'IncludeNonSecretServerSessions' {
                    $queryParams += "filter.includeNonSecretServerSessions=$([boolean]$IncludeNonSecretServerSessions)"
                }
                'IncludeOnlyLaunchedSuccessfully' {
                    $queryParams += "filter.includeOnlyLaunchedSuccessfully=$([boolean]$IncludeOnlyLaunchedSuccessfully)"
                }
                'IncludeRestricted' {
                    $queryParams += "filter.includeRestricted=$([boolean]$IncludeRestricted)"
                }
                'IncludeSubFolders' {
                    $queryParams += "filter.includeSubFolders=$([boolean]$IncludeSubFolders)"
                }
                'LauncherTypeId' {
                    $queryParams += "filter.launcherTypeId=$($LauncherTypeId)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'SecretIds' {
                    foreach ($queryValue in $SecretIds) {
                        $queryParams += "filter.secretIds=$($queryValue)"
                    }
                }
                'SiteId' {
                    $queryParams += "filter.siteId=$($SiteId)"
                }
                'StartDate' {
                    $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
                }
                'StartTime' {
                    $queryParams += "filter.startTime=$([uri]::EscapeDataString($StartTime))"
                }
                'UserIds' {
                    foreach ($queryValue in $UserIds) {
                        $queryParams += "filter.userIds=$($queryValue)"
                    }
                }
            }
            foreach ($queryValue in $SearchTypes) {
                $queryParams += "filter.searchTypes=$([uri]::EscapeDataString($queryValue))"
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssRecordedSession request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                $sessions = [Thycotic.PowerShell.RecordedSessions.RecordedSessionItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.RecordedSessions.RecordedSessionItem]))
                if ($tssParams.ContainsKey('Active')) {
                    $sessions = $sessions | Where-Object Active -EQ ([boolean]$Active)
                }
                $sessions
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
