function New-TssReportSchedule {
    <#
    .SYNOPSIS
    Create a Report Schedule for aTSS report.

    .DESCRIPTION
    Create a Report Schedule for aTSS report.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Monthly'
        ScheduleName = 'Monthly - 3rd Monday, every 3mo'
        StartOn = (Get-Date)
        MonthlyType = 'DayOfWeekMonth'
        MonthlyWeekOrder = 'Third'
        MonthlyDayOf = 'Monday'
        MonthlyWeekRecurrence = 3
    }
    New-TssReportSchedule @newSchedule

    Create a monthly schedule on the 4th day, every 3 months on Report ID 93

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Monthly'
        ScheduleName = 'Monthly - 12 day every 6 months'
        StartOn = (Get-Date)
        MonthlyType = 'DayOfMonth'
        MonthlyDay = 12
        MonthlyDayRecurrence = 6
    }
    New-TssReportSchedule @newSchedule

    Create a monthly schedule for 12th day every 6 months on Report ID 93

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Daily'
        ScheduleName = 'Daily - every 4 days'
        StartOn = (Get-Date)
        DailyRecurrence = 4
    }
    New-TssReportSchedule @newSchedule

    Create a daily schedule for every 4 days on Report ID 93

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Daily'
        ScheduleName = 'Daily - every 1 days'
        StartOn = (Get-Date)
        DailyRecurrence = 1
        SendEmail = $true
        EmailGroupId = 25, 79
        EmailAddress = 'jasonborne@contractorcompanyhere.com','spongebob@contractorcompanyhere.com'
    }
    New-TssReportSchedule @newSchedule

    Create a daily schedule for every 1 days on Report ID 93 that will be emailed to users in Groups 25 and 79, along with external emails

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Daily'
        ScheduleName = 'Health check Daily'
        StartOn = (Get-Date)
        DailyRecurrence = 1
        SendEmail = $true
        EmailGroupId = 25, 79
        HealthCheck = $true
    }
    New-TssReportSchedule @newSchedule

    Create a daily health check schedule (only emails if data is returned) every 1 days on Report ID 93 that will be emailed to users in Group ID 25 and 79 (if they have an associated email address)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSchedule = @{
        TssSession = $session
        ReportId = 93
        ScheduleType = 'Weekly'
        ScheduleName = 'Weekly - every 4 weeks on Monday and Thursday'
        StartOn = (Get-Date)
        WeeklyRecurrence = 4
        WeeklyDayOf = 'Monday','Thursday'
    }
    New-TssReportSchedule @newSchedule

    Create a weekly schedule for every 4 weeks on Monday and Thursday of each week for Report ID 93

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Reports.ReportSchedule')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Report ID
        [Parameter(Mandatory)]
        [int]
        $ReportId,

        # Report Schedule Type (Daily, Weekly, Monthly)
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.ReportScheduleType]
        $ScheduleType,

        # Schedule Name
        [Parameter(Mandatory)]
        [string]
        $ScheduleName,

        # Start date of Report Schedule
        [Parameter(Mandatory)]
        [System.DateTime]
        $StartOn,

        # Days of recurrence
        [Parameter(ParameterSetName = 'daily')]
        [int]
        $DailyRecurrence,

        # Weeks of recurrence
        [Parameter(ParameterSetName = 'weekly')]
        [int]
        $WeeklyRecurrence,

        # Days of the Week
        [Parameter(ParameterSetName = 'weekly')]
        [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')]
        [string[]]
        $WeeklyDaysOf,

        # Monthly Schedule Type (DayOfMonth, DayOfWeekMonth)
        [Parameter(ParameterSetName = 'monthly')]
        [Thycotic.PowerShell.Enums.ScheduleMonthType]
        $MonthlyType,

        # Monthly day of the month (e.g. 21 day of the month)
        [Parameter(ParameterSetName = 'monthly')]
        [Parameter(ParameterSetName = 'DayOfMonth')]
        [ValidateRange(1,31)]
        [int]
        $MonthlyDay,

        # Monthly day recurrence (e.g. every 5 months)
        [Parameter(ParameterSetName = 'monthly')]
        [Parameter(ParameterSetName = 'DayOfMonth')]
        [ValidateRange(1,12)]
        [int]
        $MonthlyDayRecurrence,

        # Monthly Week Order (Second Tuesday of the month)
        [Parameter(ParameterSetName = 'monthly')]
        [Parameter(ParameterSetName = 'DayOfWeekMonth')]
        [ValidateSet('First','Second','Third','Fourth','Last')]
        [string]
        $MonthlyWeekOrder,

        # Monthly Week - Day of the week (every Tuesday of the month)
        [Parameter(ParameterSetName = 'monthly')]
        [Parameter(ParameterSetName = 'DayOfWeekMonth')]
        [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday','WeekDay','WeekendDay','Day')]
        [string]
        $MonthlyDayOf,

        # Monthly Week recurrence in the month (every 9 months)
        [Parameter(ParameterSetName = 'monthly')]
        [Parameter(ParameterSetName = 'DayOfWeekMonth')]
        [int]
        $MonthlyWeekRecurrence,

        # Enable Health Check
        [Parameter(ParameterSetName = 'general')]
        [Parameter(ParameterSetName = 'daily')]
        [Parameter(ParameterSetName = 'weekly')]
        [Parameter(ParameterSetName = 'monthly')]
        [switch]
        $HealthCheck,

        # Send report via email
        [Parameter(ParameterSetName = 'general')]
        [Parameter(ParameterSetName = 'daily')]
        [Parameter(ParameterSetName = 'weekly')]
        [Parameter(ParameterSetName = 'monthly')]
        [switch]
        $SendEmail,

        # Send email as high priority
        [Parameter(ParameterSetName = 'general')]
        [Parameter(ParameterSetName = 'daily')]
        [Parameter(ParameterSetName = 'weekly')]
        [Parameter(ParameterSetName = 'monthly')]
        [switch]
        $EmailHighPriority,

        # Group ID(s) to receive Email
        [Parameter(ParameterSetName = 'general')]
        [Parameter(ParameterSetName = 'daily')]
        [Parameter(ParameterSetName = 'weekly')]
        [Parameter(ParameterSetName = 'monthly')]
        [int[]]
        $EmailGroupId,

        # Email Address(es) to receive report
        [Parameter(ParameterSetName = 'general')]
        [Parameter(ParameterSetName = 'daily')]
        [Parameter(ParameterSetName = 'weekly')]
        [Parameter(ParameterSetName = 'monthly')]
        [string[]]
        $EmailAddress
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'reports', 'schedules' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{schedule = @{} } }
            switch ($tssNewParams.Keys) {
                'ReportId' { $newBody.data.Add('reportId', $ReportId) }
                'StartOn' { $newBody.data.schedule.Add('startingOn',$StartOn.ToString()) }
                'ScheduleName' { $newBody.data.schedule.Add('scheduleName',$ScheduleName) }
                'SendEmail' {
                    $newBody.data.schedule.Add('sendEmail',[boolean]$SendEmail)
                    if ($tssNewParams.ContainsKey('EmailHighPriority')) {
                        $newBody.data.schedule.Add('sendEmailWithHighPriority',[boolean]$EmailHighPriority)
                    }
                    if ($tssNewParams.ContainsKey('EmailGroupId')) {
                        $newBody.data.schedule.Add('emailGroups',@($EmailGroupId))
                    }
                    if ($tssNewParams.ContainsKey('EmailAddress')) {
                        $joinedEmail = $EmailAddress -join ';'
                        $newBody.data.schedule.Add('additionalEmailAddresses',$joinedEmail)
                    }
                }
                'ScheduleType' {
                    $newBody.data.schedule.Add('changeType',$ScheduleType)
                    switch ($ScheduleType) {
                        'Daily' {
                            if ($tssNewParams.ContainsKey('DailyRecurrence')) {
                                $newBody.data.schedule.Add('days',$DailyRecurrence)
                            } else {
                                Write-Warning "Daily configuration requires a value for DailyRecurrence"
                                return
                            }
                        }
                        'Weekly' {
                            if ($tssNewParams.ContainsKey('WeeklyRecurrence')) {
                                $newBody.data.schedule.Add('weeks',$WeeklyRecurrence)
                            } else {
                                Write-Warning "Weekly configuration requires a value for WeeklyRecurrence"
                            }
                            if ($tssNewParams.ContainsKey('WeeklyDaysOf')) {
                                switch ($WeeklyDaysOf) {
                                    'Monday' { $newBody.data.schedule.Add('monday',$true) }
                                    'Tuesday' { $newBody.data.schedule.Add('tuesday',$true) }
                                    'Wednesday' { $newBody.data.schedule.Add('wednesday',$true) }
                                    'Thursday' { $newBody.data.schedule.Add('thursday',$true) }
                                    'Friday' { $newBody.data.schedule.Add('friday',$true) }
                                    'Saturday' { $newBody.data.schedule.Add('saturday',$true) }
                                    'Sunday' { $newBody.data.schedule.Add('sunday',$true) }
                                }
                            } else {
                                Write-Warning "Weekly configuration requires at least one day of the week to be provided for WeeklyDaysOf"
                            }
                        }
                        'Monthly' {
                            if ($tssNewParams.ContainsKey('MonthlyType')) {
                                $newBody.data.schedule.Add('monthlyScheduleType',[string]$MonthlyType)
                                switch ($MonthlyType) {
                                    'DayOfMonth' {
                                        if ($tssNewParams.ContainsKey('MonthlyDay')) {
                                            $newBody.data.schedule.Add('monthlyDayOfMonth',$MonthlyDay)
                                        }
                                        if ($tssNewParams.ContainsKey('MonthlyDayRecurrence')) {
                                            $newBody.data.schedule.Add('monthlyDayRecurrence',$MonthlyDayRecurrence)
                                        }
                                    }
                                    'DayOfWeekMonth' {
                                        if ($tssNewParams.ContainsKey('MonthlyWeekOrder')) {
                                            $newBody.data.schedule.Add('monthlyDayOrder',$MonthlyWeekOrder)
                                        }
                                        if ($tssNewParams.ContainsKey('MonthlyWeekRecurrence')) {
                                            $newBody.data.schedule.Add('monthlyDayOrderRecurrence',$MonthlyWeekRecurrence)
                                        }
                                        if ($tssNewParams.ContainsKey('MonthlyDayOf')) {
                                            $newBody.data.schedule.Add('monthlyDay',$MonthlyDayOf)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            $invokeParams.Body = $newBody | ConvertTo-Json -Depth 50

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Report Schedule", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating report schedule"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                . $GetReportSchedule $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}