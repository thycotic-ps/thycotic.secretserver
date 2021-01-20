class TssReportSchedule {
    # Schedule change type
    [ValidateSet('Daily','Weekly','Monthly')]
    [string]$ChangeType
    # deleted or not
    [boolean]$Deleted
    # description
    [string]$Description
    # DateTime of last run
    [datetime]$LastRun
    # History ID of last run
    [int]$LastRunHistoryId
    # schedule name
    [string]$Name
    # Report Id
    [int]$ReportId
    # Report Name
    [string]$ReportName
    # Schedule Report Id
    [int]$ScheduleReportId
    # Send report via email
    [boolean]$SendEmail
    # Number of reports stored for this schedule
    [int]$StoredReportCount
}