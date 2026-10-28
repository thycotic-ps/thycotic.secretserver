function Set-TssReportSchedule {
    <#
    .SYNOPSIS
    Set the properties of a report schedule

    .DESCRIPTION
    Set the format, report parameter values or schedule of a report schedule.
    Only the parameters provided are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report schedule ID

    .PARAMETER Format
    Format of the stored and emailed report: Html or Csv

    .PARAMETER UserParameterValue
    User ID for the report's user parameter

    .PARAMETER GroupParameterValue
    Group ID for the report's group parameter

    .PARAMETER FolderParameterValue
    Folder ID for the report's folder parameter

    .PARAMETER FolderPathParameterValue
    Folder path for the report's folder path parameter

    .PARAMETER CustomParameterValue
    Value for the report's custom text parameter

    .PARAMETER StartDateParameterValue
    Start date option for the report's start date parameter; SpecificDate uses StartDateParameterSpecificDateValue

    .PARAMETER StartDateParameterSpecificDateValue
    Start date used when StartDateParameterValue is SpecificDate

    .PARAMETER EndDateParameterValue
    End date option for the report's end date parameter; SpecificDate uses EndDateParameterSpecificDateValue

    .PARAMETER EndDateParameterSpecificDateValue
    End date used when EndDateParameterValue is SpecificDate

    .PARAMETER Schedule
    Schedule properties to change, provided as hash format of @{<property> = <value>}.
    Keys are the schedule properties of the REST API: scheduleName, changeType, days, weeks, startingOn, historySize, sendEmail, sendEmailWithHighPriority, additionalEmailAddresses, emailGroups, healthCheck, monday through sunday, monthlyScheduleType, monthlyDay, monthlyDayOfMonth, monthlyDayOrder, monthlyDayOrderRecurrence, monthlyDayRecurrence.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportSchedule -TssSession $session -Id 7 -Format Csv

    Stores and emails the runs of report schedule 7 as CSV

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReportSchedule -TssSession $session -Id 7 -StartDateParameterValue StartPreviousMonth -EndDateParameterValue EndPreviousMonth -Schedule @{historySize = 12; sendEmail = $true}

    Runs report schedule 7 over the previous month, keeps 12 runs and emails each run

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Reports.ReportSchedule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScheduleReportId', 'ReportScheduleId')]
        [int]
        $Id,

        [ValidateSet('Html', 'Csv')]
        [string]
        $Format,

        [int]
        $UserParameterValue,

        [int]
        $GroupParameterValue,

        [int]
        $FolderParameterValue,

        [string]
        $FolderPathParameterValue,

        [string]
        $CustomParameterValue,

        [ValidateSet('StartToday', 'EndToday', 'StartYesterday', 'EndYesterday', 'StartPreviousMonth', 'EndPreviousMonth', 'StartCurrentMonth', 'EndCurrentMonth', 'StartPreviousYear', 'EndPreviousYear', 'StartCurrentYear', 'EndCurrentYear', 'StartWeek', 'EndWeek', 'SpecificDate')]
        [string]
        $StartDateParameterValue,

        [datetime]
        $StartDateParameterSpecificDateValue,

        [ValidateSet('StartToday', 'EndToday', 'StartYesterday', 'EndYesterday', 'StartPreviousMonth', 'EndPreviousMonth', 'StartCurrentMonth', 'EndCurrentMonth', 'StartPreviousYear', 'EndPreviousYear', 'StartCurrentYear', 'EndCurrentYear', 'StartWeek', 'EndWeek', 'SpecificDate')]
        [string]
        $EndDateParameterValue,

        [datetime]
        $EndDateParameterSpecificDateValue,

        [hashtable]
        $Schedule
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', 'schedules', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Format' {
                    $body.data.Add('format', @{ dirty = $true; value = $Format })
                }
                'UserParameterValue' {
                    $body.data.Add('userParameterValue', @{ dirty = $true; value = $UserParameterValue })
                }
                'GroupParameterValue' {
                    $body.data.Add('groupParameterValue', @{ dirty = $true; value = $GroupParameterValue })
                }
                'FolderParameterValue' {
                    $body.data.Add('folderParameterValue', @{ dirty = $true; value = $FolderParameterValue })
                }
                'FolderPathParameterValue' {
                    $body.data.Add('folderPathParameterValue', @{ dirty = $true; value = $FolderPathParameterValue })
                }
                'CustomParameterValue' {
                    $body.data.Add('customParameterValue', @{ dirty = $true; value = $CustomParameterValue })
                }
                'StartDateParameterValue' {
                    $body.data.Add('startDateParameterValue', @{ dirty = $true; value = $StartDateParameterValue })
                }
                'StartDateParameterSpecificDateValue' {
                    $body.data.Add('startDateParameterSpecificDateValue', @{ dirty = $true; value = $StartDateParameterSpecificDateValue.ToString('s') })
                }
                'EndDateParameterValue' {
                    $body.data.Add('endDateParameterValue', @{ dirty = $true; value = $EndDateParameterValue })
                }
                'EndDateParameterSpecificDateValue' {
                    $body.data.Add('endDateParameterSpecificDateValue', @{ dirty = $true; value = $EndDateParameterSpecificDateValue.ToString('s') })
                }
                'Schedule' {
                    $scheduleBody = @{ }
                    foreach ($scheduleKey in $Schedule.Keys) {
                        $scheduleValue = $Schedule[$scheduleKey]
                        if ($scheduleValue -is [datetime]) {
                            $scheduleValue = $scheduleValue.ToString('s')
                        }
                        $scheduleBody.Add($scheduleKey, @{ dirty = $true; value = $scheduleValue })
                    }
                    $body.data.Add('schedule', $scheduleBody)
                }
            }
            if ($body.data.Count -eq 0) {
                Write-Error 'Provide at least one property to update'
                return
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Report schedule Id: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating report schedule [$Id]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    . $GetReportSchedule $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
