---
title: Get-TssEventPipelineFilterOption
parent: Event Pipelines
grand_parent: Commands
---
# Get-TssEventPipelineFilterOption

## SYNOPSIS
Get the filters available to event pipelines

## SYNTAX

```
Get-TssEventPipelineFilterOption [-TssSession] <Session> -EventEntityType <EventEntityType>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the filter definitions an event pipeline can use for an entity type.
EventPipelineFilterId and EventPipelineFilterName identify a filter for New-TssEventPipeline and Update-TssEventPipeline.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssEventPipelineFilterOption -TssSession $session -EventEntityType Secret
```

Returns the filters available to secret event pipelines

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

### Thycotic.PowerShell.EventPipeline.FilterOption[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterOption.ps1)
