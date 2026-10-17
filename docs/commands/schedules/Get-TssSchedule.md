---
title: Get-TssSchedule
parent: Schedules
grand_parent: Commands
---
# Get-TssSchedule

## SYNOPSIS
Get a recurring schedule

## SYNTAX

```
Get-TssSchedule [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Returns a recurring schedule by ID: type, duration, start date, time zone, constraints and the entity it belongs to.
Recurring schedules drive inbox rule digests.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSchedule -TssSession $session -Id 3
```

Returns recurring schedule 3

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
Type: Int32[]
Parameter Sets: (All)
Aliases: ScheduleId, RecurringScheduleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Get-TssSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/schedules/Get-TssSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Get-TssSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/schedules/Get-TssSchedule.ps1)
