---
title: New-TssSchedule
parent: Schedules
grand_parent: Commands
---
# New-TssSchedule

## SYNOPSIS
Create a recurring schedule

## SYNTAX

```
New-TssSchedule [-TssSession] <Session> -EntityId <Int32> [-EntityType <String>]
 -RecurringScheduleType <String> [-Active] [-Duration <Int32>] [-DurationStartDate <DateTime>]
 [-TimeZoneId <String>] [-Notes <String>] -ScheduleConstraint <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a recurring schedule for an entity (an inbox rule) and returns it.
Each -ScheduleConstraint item has recurrenceValueType and an integer recurrenceValue: SpecificTime is minutes after midnight in steps of 30 (540 = 09:00), DayOfWeek 0-6, DayOfMonth 1-31, WeekOfMonth 1-5, WeekOfMonthDay 0-6.
Every schedule needs at least one SpecificTime.
Weekly also uses DayOfWeek, MonthlyDays DayOfMonth, MonthlyWeeks WeekOfMonth and WeekOfMonthDay.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$constraints = @(@{ recurrenceValueType = 'SpecificTime'; recurrenceValue = 540 })
New-TssSchedule -TssSession $session -EntityId 12 -RecurringScheduleType Daily -ScheduleConstraint $constraints -Active
```

Creates an active schedule for inbox rule 12 that runs every day at 09:00 UTC

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$constraints = @(
    @{ recurrenceValueType = 'DayOfWeek'; recurrenceValue = 1 }
    @{ recurrenceValueType = 'SpecificTime'; recurrenceValue = 480 }
)
New-TssSchedule -TssSession $session -EntityId 12 -RecurringScheduleType Weekly -Duration 2 -TimeZoneId 'Eastern Standard Time' -ScheduleConstraint $constraints -Active
```

Creates a schedule for inbox rule 12 that runs every other week on day 1 at 08:00 Eastern time

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for authentication

```yaml
Type: Session
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -EntityId
ID of the entity the schedule belongs to, for example the inbox rule ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntityType
Type of the entity the schedule belongs to.
Default InboxRule

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: InboxRule
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecurringScheduleType
Schedule period

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate the schedule.
Omitted, the schedule is created inactive

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Duration
Number of periods per iteration, for example 2 with Weekly runs every other week.
Default 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -DurationStartDate
Date the schedule starts.
Secret Server keeps the date only and drops the time of day.
Default today

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZoneId
Windows time zone ID, for example UTC or Eastern Standard Time.
Default UTC

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: UTC
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
Notes

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleConstraint
Constraints: items with recurrenceValueType (SpecificTime, DayOfWeek, DayOfMonth, WeekOfMonth, WeekOfMonthDay) and an integer recurrenceValue.
At least one SpecificTime is required

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Schedules.Schedule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/New-TssSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/New-TssSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/New-TssSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/New-TssSchedule.ps1)
