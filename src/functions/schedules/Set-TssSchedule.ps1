function Set-TssSchedule {
    <#
    .SYNOPSIS
    Update a recurring schedule

    .DESCRIPTION
    Updates a recurring schedule and returns it. Only the parameters you pass are changed.
    -ScheduleConstraint replaces every constraint of the schedule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recurring schedule ID

    .PARAMETER Active
    Activate the schedule. Use -Active:$false to deactivate it

    .PARAMETER Duration
    Number of periods per iteration, for example 2 with Weekly runs every other week

    .PARAMETER DurationStartDate
    Date the schedule starts. Secret Server keeps the date only and drops the time of day

    .PARAMETER Notes
    Notes

    .PARAMETER RecurringScheduleType
    Schedule period

    .PARAMETER ScheduleConstraint
    Constraints that replace the existing ones: items with recurrenceValueType (SpecificTime, DayOfWeek, DayOfMonth, WeekOfMonth, WeekOfMonthDay) and an integer recurrenceValue. At least one SpecificTime (minutes after midnight, steps of 30) is required

    .PARAMETER TimeZoneId
    Windows time zone ID, for example UTC or Eastern Standard Time

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSchedule -TssSession $session -Id 3 -Notes 'Weekly digest' -Active:$false

    Sets the notes of recurring schedule 3 and deactivates it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Set-TssSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Set-TssSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Schedules.Schedule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScheduleId', 'RecurringScheduleId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $Duration,

        [datetime]
        $DurationStartDate,

        [string]
        $Notes,

        [ValidateSet('Daily', 'Weekly', 'MonthlyDays', 'MonthlyWeeks')]
        [string]
        $RecurringScheduleType,

        [object[]]
        $ScheduleConstraint,

        [string]
        $TimeZoneId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'schedules', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('recurringScheduleId', $Id)
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'Duration' {
                    $body.data.Add('duration', @{ dirty = $true; value = $Duration })
                }
                'DurationStartDate' {
                    $body.data.Add('durationStartDate', @{ dirty = $true; value = $DurationStartDate })
                }
                'Notes' {
                    $body.data.Add('notes', @{ dirty = $true; value = $Notes })
                }
                'RecurringScheduleType' {
                    $body.data.Add('recurringScheduleType', @{ dirty = $true; value = $RecurringScheduleType })
                }
                'ScheduleConstraint' {
                    $body.data.Add('scheduleConstraints', @{ dirty = $true; value = $ScheduleConstraint })
                }
                'TimeZoneId' {
                    $body.data.Add('timeZoneId', @{ dirty = $true; value = $TimeZoneId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Schedule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSchedule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Schedules.Schedule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Schedules.Schedule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
