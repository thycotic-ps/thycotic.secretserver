function Search-ReportSchedule {

    [cmdletbinding(DefaultParameterSetName = "filter")]
    [OutputType('TssReportSchedule')]
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
                . $TssReportScheduleObject $restReponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}