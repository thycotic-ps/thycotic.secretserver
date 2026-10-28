---
title: Search-TssEventPipelineTask
parent: Event Pipelines
grand_parent: Commands
---
# Search-TssEventPipelineTask

## SYNOPSIS
Search event pipeline task definitions

## SYNTAX

```
Search-TssEventPipelineTask [-TssSession] <Session> [-EventActionId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the task definitions event pipelines can run, optionally only those available for one event action.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelineTask -TssSession $session
```

Returns all event pipeline task definitions

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelineTask -TssSession $session -EventActionId 10044
```

Returns the tasks available when access to a secret is approved

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

### -EventActionId
Return only the tasks available for this event action (EventActionId from Get-TssEventPipelineTriggerOption)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipeline.TaskDefinition[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineTask](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineTask)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineTask.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineTask.ps1)
