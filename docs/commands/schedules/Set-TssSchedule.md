---
title: Set-TssSchedule
parent: Schedules
grand_parent: Commands
---
# Set-TssSchedule

## SYNOPSIS
Update a recurring schedule

## SYNTAX

```
Set-TssSchedule [-TssSession] <Session> -Id <Int32> [-Active] [-Duration <Int32>]
 [-DurationStartDate <DateTime>] [-Notes <String>] [-RecurringScheduleType <String>]
 [-ScheduleConstraint <Object[]>] [-TimeZoneId <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a recurring schedule and returns it.
Only the parameters you pass are changed.
-ScheduleConstraint replaces every constraint of the schedule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSchedule -TssSession $session -Id 3 -Notes 'Weekly digest' -Active:$false
```

Sets the notes of recurring schedule 3 and deactivates it

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

### -Id
Recurring schedule ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScheduleId, RecurringScheduleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Activate the schedule.
Use -Active:$false to deactivate it

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
Number of periods per iteration, for example 2 with Weekly runs every other week

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DurationStartDate
Date the schedule starts.
Secret Server keeps the date only and drops the time of day

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### -RecurringScheduleType
Schedule period

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
Constraints that replace the existing ones: items with recurrenceValueType (SpecificTime, DayOfWeek, DayOfMonth, WeekOfMonth, WeekOfMonthDay) and an integer recurrenceValue.
At least one SpecificTime (minutes after midnight, steps of 30) is required

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZoneId
Windows time zone ID, for example UTC or Eastern Standard Time

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Set-TssSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Set-TssSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Set-TssSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Set-TssSchedule.ps1)
