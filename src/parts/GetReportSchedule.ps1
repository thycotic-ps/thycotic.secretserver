param(
    [Parameter(Position = 0)]
    [PSCustomObject]$Object
)
process {
    foreach ($sch in $Object) {
        $folderParameters = @()
        $groupParameters = @()
        $schedules = @()
        $userParameters = @()

        if ($sch.schedule) {
            $emailGroups = @()
            if ($sch.schedule.emailGroups) {
                foreach ($g in $sch.schedule.emailGroups.value) {
                    $emailGroups += [Thycotic.PowerShell.Reports.Subscriber]@{
                        DisplayName = $g.displayName
                        GroupId = $g.groupId
                    }
                }
            }
            $schedules = [Thycotic.PowerShell.Reports.ScheduleView]@{
                AdditionalEmailAddresses = $sch.schedule.AdditionalEmailAddresses.value
                ChangeType = $sch.schedule.changeType.value
                Days = $sch.schedule.days.value
                EmailGroups = $emailGroups
                Friday = $sch.schedule.friday.value
                HealthCheck = $sch.schedule.healthCheck.value
                HistorySize = $sch.schedule.historySize.value
                Monday = $sch.schedule.monday.value
                MonthlyDay = $sch.schedule.monthlyDay.value
                MonthlyDayOfMonth = $sch.schedule.monthlyDayOfMonth.value
                MonthlyDayOrder = $sch.schedule.monthlyDayOrder.value
                MonthlyDayOrderRecurrence = $sch.schedule.monthlyDayOrderRecurrence.value
                MonthlyDayRecurrence = $sch.schedule.monthlyDayRecurrence.value
                MonthlyScheduleType = $sch.schedule.monthlyScheduleType.value
                Saturday = $sch.schedule.saturday.value
                ScheduleName = $sch.schedule.scheduleName.value
                SendEmail = $sch.schedule.sendEmail.value
                SendEmailWithHighPriority = $sch.schedule.sendEmailWithHighPriority.value
                StartingOn = $sch.schedule.startingOn.value
                Sunday = $sch.schedule.sunday.value
                Thursday = $sch.schedule.thursday.value
                Tuesday = $sch.schedule.tuesday.value
                Wednesday = $sch.schedule.wednesday.value
                Weeks = $sch.schedule.weeks.value
            }
        }
        if ($sch.userParameterValue) {
            foreach ($s in $sch.folderParameterValue) {
                $folderParameters += [Thycotic.PowerShell.Reports.ParameterValue]@{
                    Name             = $s.Name
                    Value            = $s.Value
                    ValueDisplayName = $s.ValueDisplayName
                }
            }
        }
        if ($sch.userParameterValue) {
            foreach ($s in $sch.groupParameterValue) {
                $groupParameters += [Thycotic.PowerShell.Reports.ParameterValue]@{
                    Name             = $s.Name
                    Value            = $s.Value
                    ValueDisplayName = $s.ValueDisplayName
                }
            }
        }
        if ($sch.userParameterValue) {
            foreach ($s in $sch.userParameterValue) {
                $userParameters += [Thycotic.PowerShell.Reports.ParameterValue]@{
                    Name             = $s.Name
                    Value            = $s.Value
                    ValueDisplayName = $s.ValueDisplayName
                }
            }
        }
        [Thycotic.PowerShell.Reports.ReportSchedule]@{
            CustomParameterValue = $sch.CustomParameterValue
            EndDateParameterSpecificDateValue = $sch.EndDateParameterSpecificDateValue
            EndDateParameterValue = $sch.EndDateParameterValue
            FolderParameter = if ($folderParameters) {$folderParameters} else {$null}
            Format = $sch.Format
            GroupParameterValue = if ($groupParameters) {$groupParameters} else {$null}
            ReportId = $sch.ReportId
            ReportName = $sch.ReportName
            Schedule = $schedules
            ScheduleReportId = $sch.ScheduleReportId
            StartDateParameterSpecificDateValue = $sch.StartDateParameterSpecificDateValue
            StartDateParameterValue = $sch.StartDateParameterValue
            UserParameterValue = if ($userParameters) {$userParameters} else {$null}
        }
    }
}