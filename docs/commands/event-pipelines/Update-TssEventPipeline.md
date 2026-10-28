---
title: Update-TssEventPipeline
parent: Event Pipelines
grand_parent: Commands
---
# Update-TssEventPipeline

## SYNOPSIS
Update an event pipeline

## SYNTAX

```
Update-TssEventPipeline [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>] [-Active]
 [-TriggerActionId <Int32[]>] [-Task <Object[]>] [-Filter <Object[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing event pipeline.
Only the parameters provided are changed.
TriggerActionId, Task and Filter each replace the whole set of triggers, tasks or filters of the pipeline.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssEventPipeline -TssSession $session -Id 12 -Name 'Audit approvals (secrets)' -Description 'Writes an audit entry on approval'
```

Renames pipeline 12 and sets its description; triggers, tasks and filters are unchanged

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssEventPipeline -TssSession $session -Id 12 -Active:$false
```

Deactivates pipeline 12

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
Event pipeline ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: EventPipelineId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New event pipeline name

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelineName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
New event pipeline description

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelineDescription

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Set the pipeline active (-Active) or inactive (-Active:$false)

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

### -TriggerActionId
Event action IDs that trigger the pipeline (EventActionId from Get-TssEventPipelineTriggerOption).
Replaces the current triggers

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventActionId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Task
Tasks to run, in order.
Each item is a hashtable or object with EventPipelineTaskId (required), EventPipelineTaskName, SortOrder and Settings (hashtable of setting name to value).
Output of Get-TssEventPipelineTaskOption can be used as items.
Replaces the current tasks

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

### -Filter
Filters the event must pass, in order.
Each item is a hashtable or object with EventPipelineFilterId (required), EventPipelineFilterName, SortOrder and Settings (hashtable of setting name to value).
Replaces the current filters

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

### Thycotic.PowerShell.EventPipeline.List
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipeline](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipeline)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipeline.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipeline.ps1)
