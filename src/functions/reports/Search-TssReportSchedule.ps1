function Search-TssReportSchedule {
    <#
    .SYNOPSIS
    Search report schedule

    .DESCRIPTION
    Search for report schedule(s)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportSchedule -TssSession $session -ReportId 50

    Return all schedules found associated with Report ID 50.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportSchedule -TssSession $session -IncludeDeleted

    Returns list of all report schedules, including those that were deleted

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Serach-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.Reports.ScheduleSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Include deleted reports
        [switch]
        $IncludeDeleted,

        # Report ID
        [int]
        $ReportId,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'reports', 'schedules' -join '/'
            $uri += "?sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)"

            $filters = @()
            if ($tssParams.ContainsKey('IncludeDeleted')) {
                $filters += "filter.includeDeleted=$([boolean]$IncludeDeleted)"
            }
            if ($tssParams.ContainsKey('ReportId')) {
                $filters += "filter.reportId=$ReportId"
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
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No report schedules found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Reports.ScheduleSummary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}