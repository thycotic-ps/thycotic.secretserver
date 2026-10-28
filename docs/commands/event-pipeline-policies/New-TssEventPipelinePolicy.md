---
title: New-TssEventPipelinePolicy
parent: Event Pipeline Policies
grand_parent: Commands
---
# New-TssEventPipelinePolicy

## SYNOPSIS
Create a new event pipeline policy

## SYNTAX

```
New-TssEventPipelinePolicy [-TssSession] <Session> -Name <String> -EventEntityType <EventEntityType>
 [-Description <String>] [-Active] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates an empty event pipeline policy for an entity type.
Add pipelines with New-TssEventPipeline or Add-TssEventPipeline.
Without -Active the policy is created inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssEventPipelinePolicy -TssSession $session -Name 'Secret approvals' -EventEntityType Secret -Description 'Pipelines for approval events' -Active
```

Creates an active secret event pipeline policy

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

### -Name
Event pipeline policy name

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelinePolicyName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventEntityType
Entity type the policy acts on, such as Secret, User or Group

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

### -Description
Event pipeline policy description

```yaml
Type: String
Parameter Sets: (All)
Aliases: EventPipelinePolicyDescription

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Create the policy active.
Without it the policy is created inactive

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

### Thycotic.PowerShell.EventPipelinePolicy.Policy
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/New-TssEventPipelinePolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/New-TssEventPipelinePolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/New-TssEventPipelinePolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/New-TssEventPipelinePolicy.ps1)
