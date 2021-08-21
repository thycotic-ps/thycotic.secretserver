# New-TssReportSchedule

## SYNOPSIS
Create a Report Schedule for aTSS report.

## SYNTAX

### daily
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-DailyRecurrence <Int32>] [-HealthCheck] [-SendEmail]
 [-EmailHighPriority] [-EmailGroupId <Int32[]>] [-EmailAddress <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### weekly
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-WeeklyRecurrence <Int32>] [-WeeklyDaysOf <String[]>]
 [-HealthCheck] [-SendEmail] [-EmailHighPriority] [-EmailGroupId <Int32[]>] [-EmailAddress <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### monthly
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-MonthlyType <ScheduleMonthType>] [-MonthlyDay <Int32>]
 [-MonthlyDayRecurrence <Int32>] [-MonthlyWeekOrder <String>] [-MonthlyDayOf <String>]
 [-MonthlyWeekRecurrence <Int32>] [-HealthCheck] [-SendEmail] [-EmailHighPriority] [-EmailGroupId <Int32[]>]
 [-EmailAddress <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DayOfMonth
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-MonthlyDay <Int32>] [-MonthlyDayRecurrence <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### DayOfWeekMonth
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-MonthlyWeekOrder <String>] [-MonthlyDayOf <String>]
 [-MonthlyWeekRecurrence <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### general
```
New-TssReportSchedule [-TssSession] <Session> -ReportId <Int32> -ScheduleType <ReportScheduleType>
 -ScheduleName <String> -StartOn <DateTime> [-HealthCheck] [-SendEmail] [-EmailHighPriority]
 [-EmailGroupId <Int32[]>] [-EmailAddress <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a Report Schedule for aTSS report.

## EXAMPLES

### EXAMPLE 1
```
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
```

Create a monthly schedule on the 4th day, every 3 months on Report ID 93

### EXAMPLE 2
```
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
```

Create a monthly schedule for 12th day every 6 months on Report ID 93

### EXAMPLE 3
```
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
```

Create a daily schedule for every 4 days on Report ID 93

### EXAMPLE 4
```
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
```

Create a daily schedule for every 1 days on Report ID 93 that will be emailed to users in Groups 25 and 79, along with external emails

### EXAMPLE 5
```
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
```

Create a daily health check schedule (only emails if data is returned) every 1 days on Report ID 93 that will be emailed to users in Group ID 25 and 79 (if they have an associated email address)

### EXAMPLE 6
```
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
```

Create a weekly schedule for every 4 weeks on Monday and Thursday of each week for Report ID 93

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

### -ReportId
Report ID

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

### -ScheduleType
Report Schedule Type (Daily, Weekly, Monthly)

```yaml
Type: ReportScheduleType
Parameter Sets: (All)
Aliases:
Accepted values: Daily, Weekly, Monthly

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleName
Schedule Name

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

### -StartOn
Start date of Report Schedule

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DailyRecurrence
Days of recurrence

```yaml
Type: Int32
Parameter Sets: daily
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeeklyRecurrence
Weeks of recurrence

```yaml
Type: Int32
Parameter Sets: weekly
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeeklyDaysOf
Days of the Week

```yaml
Type: String[]
Parameter Sets: weekly
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyType
Monthly Schedule Type (DayOfMonth, DayOfWeekMonth)

```yaml
Type: ScheduleMonthType
Parameter Sets: monthly
Aliases:
Accepted values: DayOfWeekMonth, DayOfMonth

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyDay
Monthly day of the month (e.g.
21 day of the month)

```yaml
Type: Int32
Parameter Sets: monthly, DayOfMonth
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyDayRecurrence
Monthly day recurrence (e.g.
every 5 months)

```yaml
Type: Int32
Parameter Sets: monthly, DayOfMonth
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyWeekOrder
Monthly Week Order (Second Tuesday of the month)

```yaml
Type: String
Parameter Sets: monthly, DayOfWeekMonth
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyDayOf
Monthly Week - Day of the week (every Tuesday of the month)

```yaml
Type: String
Parameter Sets: monthly, DayOfWeekMonth
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyWeekRecurrence
Monthly Week recurrence in the month (every 9 months)

```yaml
Type: Int32
Parameter Sets: monthly, DayOfWeekMonth
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthCheck
Enable Health Check

```yaml
Type: SwitchParameter
Parameter Sets: daily, weekly, monthly, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendEmail
Send report via email

```yaml
Type: SwitchParameter
Parameter Sets: daily, weekly, monthly, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailHighPriority
Send email as high priority

```yaml
Type: SwitchParameter
Parameter Sets: daily, weekly, monthly, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailGroupId
Group ID(s) to receive Email

```yaml
Type: Int32[]
Parameter Sets: daily, weekly, monthly, general
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailAddress
Email Address(es) to receive report

```yaml
Type: String[]
Parameter Sets: daily, weekly, monthly, general
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

### Thycotic.PowerShell.Reports.ReportSchedule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportSchedule](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportSchedule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportSchedule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportSchedule.ps1)

