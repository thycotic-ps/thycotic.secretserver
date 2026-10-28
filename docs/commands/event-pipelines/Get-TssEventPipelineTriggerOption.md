---
title: Get-TssEventPipelineTriggerOption
parent: Event Pipelines
grand_parent: Commands
---
# Get-TssEventPipelineTriggerOption

## SYNOPSIS
Get the triggers available to event pipelines

## SYNTAX

```
Get-TssEventPipelineTriggerOption [-TssSession] <Session> -EventEntityType <EventEntityType>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the event actions that can trigger an event pipeline for an entity type.
EventActionId is the value for the TriggerActionId parameter of New-TssEventPipeline and Update-TssEventPipeline.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineTriggerOption -TssSession $session -EventEntityType Secret | Where-Object TriggerDisplayName -like '*approved*'
```

Returns the secret triggers that fire on an approval

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

### -EventEntityType
Entity type the options apply to, such as Secret, User or Group

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipeline.TriggerView[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTriggerOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTriggerOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTriggerOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTriggerOption.ps1)
