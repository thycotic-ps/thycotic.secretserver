---
title: Set-TssDiscoveryDependencyRule
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryDependencyRule

## SYNOPSIS
Update a Discovery dependency rule

## SYNTAX

```
Set-TssDiscoveryDependencyRule [-TssSession] <Session> -Id <Int32> [-DiscoverySourceId <Int32>] [-IsActive]
 [-OrganizationUnitId <Int32>] [-PrivilegedAccountSecretId <Int32>] [-RestartServices] [-RuleName <String>]
 [-ScanTemplateId <Int32>] [-SecretDependencyTemplateId <Int32>] [-SiteId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the given fields of a Discovery dependency rule and returns the updated rule.
Fields not given are unchanged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryDependencyRule -TssSession $session -Id 4 -RuleName 'Web farm app pools' -RestartServices
```

Rename dependency rule 4 and restart services after a password change

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryDependencyRule -TssSession $session -Id 4 -IsActive:$false
```

Deactivate dependency rule 4

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
Dependency rule id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: RuleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DiscoverySourceId
Discovery source the rule applies to

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

### -IsActive
Activate the rule; use -IsActive:$false to deactivate it

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

### -OrganizationUnitId
Organizational unit the rule applies to

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

### -PrivilegedAccountSecretId
Secret of the privileged account used to manage the dependencies

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

### -RestartServices
Restart the services after a password change; use -RestartServices:$false to stop

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

### -RuleName
Rule name

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

### -ScanTemplateId
Dependency scan template id (scan type 4)

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

### -SecretDependencyTemplateId
Dependency template that sets the dependency type

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

### -SiteId
Site that runs the dependency changes

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

### Thycotic.PowerShell.Discovery.DependencyRule
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRule.ps1)
