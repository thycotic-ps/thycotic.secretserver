function Search-TssReportScheduleHistory {
    <#
    .SYNOPSIS
    Search the run history of a report schedule

    .DESCRIPTION
    Search the run history of a report schedule: one entry (ScheduleReportHistoryId and DateRun) per stored run.
    With HistoryId it returns that stored run itself, including the report output as HTML when the run was stored as HTML.
    Use Save-TssReportScheduleHistory to download the stored report file of a run.
    Returns up to the session's Take value of entries per schedule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report schedule ID

    .PARAMETER HistoryId
    Report schedule history ID (ScheduleReportHistoryId of a run)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportScheduleHistory -TssSession $session -Id 7

    Returns the stored runs of report schedule 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssReportScheduleHistory -TssSession $session -HistoryId 112

    Returns stored run 112: when it ran, its format and its HTML output

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportScheduleHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportScheduleHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'schedule')]
    [OutputType('Thycotic.PowerShell.Reports.ScheduleHistorySummary[]', ParameterSetName = 'schedule')]
    [OutputType('Thycotic.PowerShell.Reports.ScheduleHistory', ParameterSetName = 'history')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'schedule')]
        [Alias('ScheduleReportId', 'ReportScheduleId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'history')]
        [Alias('ScheduleReportHistoryId')]
        [int[]]
        $HistoryId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $invokeParams.Method = 'GET'
            if ($PSCmdlet.ParameterSetName -eq 'history') {
                foreach ($currentId in $HistoryId) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports', 'schedules', $currentId, 'history' -join '/'
                    $invokeParams.Uri = $uri
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting report schedule history [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Reports.ScheduleHistory](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Reports.ScheduleHistory]))
                    }
                }
            } else {
                foreach ($currentId in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports', 'schedules', $currentId, 'history', 'search' -join '/'
                    $uri = $uri, "take=$($TssSession.Take)" -join '?'
                    $invokeParams.Uri = $uri
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting history of report schedule [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.Reports.ScheduleHistorySummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Reports.ScheduleHistorySummary]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
