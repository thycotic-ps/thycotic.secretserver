---
title: New-TssDiscoveryDependencyRule
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoveryDependencyRule

## SYNOPSIS
Create a Discovery dependency rule

## SYNTAX

```
New-TssDiscoveryDependencyRule [-TssSession] <Session> -DiscoverySourceId <Int32> [-OrganizationUnitId <Int32>]
 [-PrivilegedAccountSecretId <Int32>] [-RestartServices] -RuleName <String> -ScanTemplateId <Int32>
 -SecretDependencyTemplateId <Int32> [-SiteId <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Discovery dependency rule that imports dependencies found by a scan template on a discovery source, and returns the created rule.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoveryDependencyRule -TssSession $session -RuleName 'Web farm services' -DiscoverySourceId 1 -ScanTemplateId 15 -SecretDependencyTemplateId 6 -PrivilegedAccountSecretId 42 -RestartServices
```

Create a Windows service dependency rule for discovery source 1 that uses secret 42 and restarts services after a password change

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

### -DiscoverySourceId
Discovery source the rule applies to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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
Secret of the privileged account used to manage the dependencies.
Required when Get-TssDiscoveryDependencyRuleInfo returns IsPrivilegedSecretRequired for the scan template

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
Restart the services after a password change

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

Required: True
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

Required: True
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

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyRule.ps1)
