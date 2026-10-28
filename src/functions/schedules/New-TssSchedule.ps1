function New-TssSchedule {
    <#
    .SYNOPSIS
    Create a recurring schedule

    .DESCRIPTION
    Creates a recurring schedule for an entity (an inbox rule) and returns it.
    Each -ScheduleConstraint item has recurrenceValueType and an integer recurrenceValue: SpecificTime is minutes after midnight in steps of 30 (540 = 09:00), DayOfWeek 0-6, DayOfMonth 1-31, WeekOfMonth 1-5, WeekOfMonthDay 0-6.
    Every schedule needs at least one SpecificTime. Weekly also uses DayOfWeek, MonthlyDays DayOfMonth, MonthlyWeeks WeekOfMonth and WeekOfMonthDay.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EntityId
    ID of the entity the schedule belongs to, for example the inbox rule ID

    .PARAMETER EntityType
    Type of the entity the schedule belongs to. Default InboxRule

    .PARAMETER RecurringScheduleType
    Schedule period

    .PARAMETER Active
    Activate the schedule. Omitted, the schedule is created inactive

    .PARAMETER Duration
    Number of periods per iteration, for example 2 with Weekly runs every other week. Default 1

    .PARAMETER DurationStartDate
    Date the schedule starts. Secret Server keeps the date only and drops the time of day. Default today

    .PARAMETER TimeZoneId
    Windows time zone ID, for example UTC or Eastern Standard Time. Default UTC

    .PARAMETER Notes
    Notes

    .PARAMETER ScheduleConstraint
    Constraints: items with recurrenceValueType (SpecificTime, DayOfWeek, DayOfMonth, WeekOfMonth, WeekOfMonthDay) and an integer recurrenceValue. At least one SpecificTime is required

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $constraints = @(@{ recurrenceValueType = 'SpecificTime'; recurrenceValue = 540 })
    New-TssSchedule -TssSession $session -EntityId 12 -RecurringScheduleType Daily -ScheduleConstraint $constraints -Active

    Creates an active schedule for inbox rule 12 that runs every day at 09:00 UTC

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $constraints = @(
        @{ recurrenceValueType = 'DayOfWeek'; recurrenceValue = 1 }
        @{ recurrenceValueType = 'SpecificTime'; recurrenceValue = 480 }
    )
    New-TssSchedule -TssSession $session -EntityId 12 -RecurringScheduleType Weekly -Duration 2 -TimeZoneId 'Eastern Standard Time' -ScheduleConstraint $constraints -Active

    Creates a schedule for inbox rule 12 that runs every other week on day 1 at 08:00 Eastern time

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/New-TssSchedule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/New-TssSchedule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Schedules.Schedule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $EntityId,

        [ValidateSet('InboxRule')]
        [string]
        $EntityType = 'InboxRule',

        [Parameter(Mandatory)]
        [ValidateSet('Daily', 'Weekly', 'MonthlyDays', 'MonthlyWeeks')]
        [string]
        $RecurringScheduleType,

        [switch]
        $Active,

        [ValidateRange(1, [int]::MaxValue)]
        [int]
        $Duration = 1,

        [datetime]
        $DurationStartDate = (Get-Date),

        [ValidateNotNullOrEmpty()]
        [string]
        $TimeZoneId = 'UTC',

        [string]
        $Notes,

        [Parameter(Mandatory)]
        [object[]]
        $ScheduleConstraint
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'schedules' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    entity                = @{ entityType = $EntityType; entityId = $EntityId }
                    recurringScheduleType = $RecurringScheduleType
                    active                = [boolean]$Active
                    duration              = $Duration
                    durationStartDate     = $DurationStartDate
                    timeZoneId            = $TimeZoneId
                    scheduleConstraints   = @($ScheduleConstraint)
                }
            }
            if ($tssParams.ContainsKey('Notes')) {
                $body.data.Add('notes', $Notes)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("$EntityType $EntityId schedule", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSchedule request'
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
