---
title: Search-TssEventPipelinePolicyRun
parent: Event Pipeline Policies
grand_parent: Commands
---
# Search-TssEventPipelinePolicyRun

## SYNOPSIS
Search event pipeline policy runs

## SYNTAX

```
Search-TssEventPipelinePolicyRun [-TssSession] <Session> [-EntityTypeName <String>] [-EventDateFrom <DateTime>]
 [-EventDateTo <DateTime>] [-EventPipelinePolicyId <Int32>] [-EventPipelinePolicyRunId <String>]
 [-ItemName <String>] [-PipelineName <String>] [-PolicyName <String>] [-Status <String>]
 [-TriggerName <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the runs of event pipeline policies, newest first, filtered by the parameters given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelinePolicyRun -TssSession $session -EventPipelinePolicyId 3
```

Returns the runs of event pipeline policy 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelinePolicyRun -TssSession $session -Status Failed -EventDateFrom (Get-Date).AddDays(-1)
```

Returns the failed runs of the last day

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

### -EntityTypeName
Entity type name, such as Secret or User

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

### -EventDateFrom
Return runs for events on or after this date

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

### -EventDateTo
Return runs for events on or before this date

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

### -EventPipelinePolicyId
Event pipeline policy ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PolicyId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventPipelinePolicyRunId
Event pipeline policy run ID (a GUID)

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

### -ItemName
Name of the item (secret, user, group) the event was about

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

### -PipelineName
Event pipeline name

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

### -PolicyName
Event pipeline policy name

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

### -Status
Run status, such as Queued, Running, Completed or Failed

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

### -TriggerName
Trigger (event action) name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipelinePolicy.Run[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicyRun](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicyRun)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicyRun.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicyRun.ps1)
