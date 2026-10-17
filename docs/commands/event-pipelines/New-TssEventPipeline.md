---
title: New-TssEventPipeline
parent: Event Pipelines
grand_parent: Commands
---
# New-TssEventPipeline

## SYNOPSIS
Create a new event pipeline

## SYNTAX

```
New-TssEventPipeline [-TssSession] <Session> [-EventPipelinePolicyId <Int32>]
 -EventEntityType <EventEntityType> -Name <String> [-Description <String>] [-Active] -TriggerActionId <Int32[]>
 -Task <Object[]> [-Filter <Object[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates an event pipeline with its triggers, tasks and optional filters, and adds it to an event pipeline policy when EventPipelinePolicyId is given.
Trigger event action IDs come from Get-TssEventPipelineTriggerOption, task definitions from Get-TssEventPipelineTaskOption and filter definitions from Get-TssEventPipelineFilterOption.
A task that has settings (Get-TssEventPipelineTaskSetting) must be given a value for each of them in its Settings hashtable.
Without -Active the pipeline is created inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$task = @{ EventPipelineTaskId = 35; EventPipelineTaskName = 'AddCustomAudit'; Settings = @{ Comment = 'Access approved' } }
New-TssEventPipeline -TssSession $session -EventPipelinePolicyId 3 -EventEntityType Secret -Name 'Audit approvals' -TriggerActionId 10044 -Task $task -Active
```

Creates an active pipeline in policy 3 that writes a custom audit entry when access to a secret is approved

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$deactivate = Get-TssEventPipelineTaskOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineTaskName -eq 'Deactivate'
New-TssEventPipeline -TssSession $session -EventEntityType Secret -Name 'Deactivate on expiry' -TriggerActionId 10010 -Task $deactivate
```

Creates an inactive pipeline, outside any policy, that deactivates a secret when the trigger fires

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

### -EventPipelinePolicyId
Event pipeline policy to add the pipeline to

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

### -EventEntityType
Entity type the pipeline acts on, such as Secret, User or Group.
Must match the policy

```yaml
Type: EventEntityType
Parameter Sets: (All)
Aliases: EventEntityTypeId
Accepted values: Unknown, User, Folder, Role, RolePermission, Configuration, Group, IpAddressRange, Secret, UnlimitedAdmin, ExportSecrets, ImportSecrets, UserAudit, SecretTemplate, Licenses, ScriptPowerShell, SecretPolicy, ScriptSsh, ScriptSsql, Encryption, Site, Engine, SiteConnector, SecurityAnalyticsConfiguration, DualControl, Tls, PasswordChanger, CharacterSet, PasswordRequirement, Domain, BackupConfiguration, SecretServerSettings, AutoExport

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Event pipeline name

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelineName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Event pipeline description

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
Create the pipeline active.
Without it the pipeline is created inactive

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
Event action IDs that trigger the pipeline (EventActionId from Get-TssEventPipelineTriggerOption)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventActionId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Task
Tasks to run, in order.
Each item is a hashtable or object with EventPipelineTaskId (required), EventPipelineTaskName, SortOrder and Settings (hashtable of setting name to value).
Output of Get-TssEventPipelineTaskOption can be used as items

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

### -Filter
Filters the event must pass, in order.
Each item is a hashtable or object with EventPipelineFilterId (required), EventPipelineFilterName, SortOrder and Settings (hashtable of setting name to value)

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/New-TssEventPipeline](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/New-TssEventPipeline)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/New-TssEventPipeline.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/New-TssEventPipeline.ps1)
