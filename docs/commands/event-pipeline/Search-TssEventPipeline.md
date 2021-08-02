# Search-TssEventPipeline

## SYNOPSIS
Get a list of Event Pipeline Policies

## SYNTAX

```
Search-TssEventPipeline [-TssSession] <Session> [-PipelinePolicyId <Int32>] [-PipelineName <String>]
 [-EventEntityType <EventEntityType>] [-IncludeInactive] [-ExcludeActive] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get a list of Event Pipeline Policies

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipeline -TssSession $session
```

Return a list of all active Event Pipeline Policies

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipeline -TssSession $session -IncludeInactive
```

Return a list of all active and inactive Event Pipeline Policies

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

### -PipelinePolicyId
Event Pipeline Policy ID

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

### -PipelineName
Event Pipeline Name

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

### -EventEntityType
Event Entity Type

```yaml
Type: EventEntityType
Parameter Sets: (All)
Aliases:
Accepted values: Unknown, User, Folder, Role, RolePermission, Configuration, Group, IpAddressRange, Secret, UnlimitedAdmin, ExportSecrets, ImportSecrets, UserAudit, SecretTemplate, Licenses, ScriptPowerShell, SecretPolicy, ScriptSsh, ScriptSsql, Encryption, Site, Engine, SiteConnector, SecurityAnalyticsConfiguration, DualControl, Tls, PasswordChanger, CharacterSet, PasswordRequirement, Domain, BackupConfiguration, SecretServerSettings, AutoExport

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive policies

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

### -ExcludeActive
Exclude Active policies

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

### -SortBy
Sort by specific property, default EventPipelineName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: EventPipelineName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.EventPipeline.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Search-TssEventPipeline](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Search-TssEventPipeline)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipeline.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipeline.ps1)

