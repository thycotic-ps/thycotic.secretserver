class TssReportScheduleSummary {
    [ValidateSet('Daily','Weekly','Monthly')]
    [string]
    $ChangeType

    [boolean]
    $Deleted

    [string]
    $Description

    [datetime]
    $LastRun

    [int]
    $LastRunHistoryId

    [string]
    $Name

    [int]
    $ReportId

    [string]
    $ReportName

    [int]
    $ScheduleReportId

    [boolean]
    $SendEmail

    [int]
    $StoredReportCount
}