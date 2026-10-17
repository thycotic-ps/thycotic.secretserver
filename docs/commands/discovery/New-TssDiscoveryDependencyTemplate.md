---
title: New-TssDiscoveryDependencyTemplate
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoveryDependencyTemplate

## SYNOPSIS
Create a Discovery dependency template

## SYNTAX

```
New-TssDiscoveryDependencyTemplate [-TssSession] <Session> [-Active] -ScanItemTemplateId <Int32>
 [-SecretDependencyChangerId <Int32>] [-SecretDependencyTemplateDescription <String>]
 -SecretDependencyTemplateName <String> -SecretDependencyTypeId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Discovery dependency template that maps a dependency type to a scan template, and returns the created template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoveryDependencyTemplate -TssSession $session -SecretDependencyTemplateName 'Custom app pools' -SecretDependencyTypeId 7 -ScanItemTemplateId 9 -Active
```

Create an active dependency template for dependency type 7 on scan template 9

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

### -Active
Create the template active.
Without it the template is created inactive

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

### -ScanItemTemplateId
Scan template the dependency template uses

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

### -SecretDependencyChangerId
Dependency changer the template uses

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

### -SecretDependencyTemplateDescription
Template description

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

### -SecretDependencyTemplateName
Template name

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

### -SecretDependencyTypeId
Dependency type id (see Search-TssDiscoveryDependencyType)

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

### Thycotic.PowerShell.Discovery.DependencyTemplate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryDependencyTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryDependencyTemplate.ps1)
