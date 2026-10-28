---
title: Get-TssEventPipelineTaskSetting
parent: Event Pipelines
grand_parent: Commands
---
# Get-TssEventPipelineTaskSetting

## SYNOPSIS
Get the settings of an event pipeline task

## SYNTAX

```
Get-TssEventPipelineTaskSetting [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the settings a task definition takes, with their default values.
Setting.SettingName is the key to use in the Settings hashtable of a New-TssEventPipeline or Update-TssEventPipeline task.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineTaskSetting -TssSession $session -Id 35
```

Returns the settings of task 35

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineTaskOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineTaskName -eq 'AddCustomAudit' | Get-TssEventPipelineTaskSetting -TssSession $session
```

Returns the settings of the AddCustomAudit task

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
Event pipeline task ID (EventPipelineTaskId from Get-TssEventPipelineTaskOption)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventPipelineTaskId

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

### Thycotic.PowerShell.EventPipeline.TaskSettingMap[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTaskSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTaskSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTaskSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTaskSetting.ps1)
