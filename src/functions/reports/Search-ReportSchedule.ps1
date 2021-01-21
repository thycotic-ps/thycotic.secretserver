function Search-ReportSchedule {
    <#
    .SYNOPSIS
    Search report schedule

    .DESCRIPTION
    Search for report schedule(s)

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssReportSchedule -TssSession $session -ReportId 50

    Return all schedules found associated with Report ID 50.

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssReportSchedule -TssSession $session -IncludeDeleted

    Returns list of all report schedules, including those that were deleted

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = "filter")]
    [OutputType('TssReportScheduleSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Include deleted reports
        [switch]
        $IncludeDeleted,

        # Report ID
        [int]
        $ReportId,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $SearchReportSchedParams $PSBoundParameters
        $invokeParams = @{ }

        $reportSchedParams = . $SearchReportSchedParams $PSBoundParameters
        $reportSchedParams.Remove('TssSession')
        $reportSchedParams.Remove('Raw')

    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $uri = $TssSession.ApiUrl, 'reports', 'schedules' -join '/'
            $uri += "?take=$($TssSession.Take)"

            $filters = @()
            if ($reportSchedParams.Contains('IncludeDeleted')) {
                $filters += "filter.includeDeleted=$IncludeDeleted"
            }
            if ($reportSchedParams.Contains('ReportId')) {
                $filters += "filter.reportId=$ReportId"
            }
            $uriFilter = $filters -join '&'
            Write-Verbose "Filters: $uriFilter"
            $uri = $uri, $uriFilter -join '&'

            $invokeParams.Uri = $uri
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            $invokeParams.Method = 'GET'
            Write-Verbose "$($invokeParams.Method) $uri"
            try {
                $restReponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_.ErrorDetails.Message
                Write-Error $err
            }

            if ($tssParams['Raw']) {
                return $restReponse
            }
            if ($restReponse.records.Count -le 0 -and $restReponse.records.Length -eq 0) {
                Write-Warning "No report schedules found"
            }
            if ($restReponse.records) {
                . $TssReportScheduleSummaryObject $restReponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}