---
title: Set-TssDiscoveryDependencyTemplate
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryDependencyTemplate

## SYNOPSIS
Update a Discovery dependency template

## SYNTAX

```
Set-TssDiscoveryDependencyTemplate [-TssSession] <Session> -Id <Int32> [-Active] [-ScanItemTemplateId <Int32>]
 [-SecretDependencyChangerId <Int32>] [-SecretDependencyTemplateDescription <String>]
 [-SecretDependencyTemplateName <String>] [-SecretDependencyTypeId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the given fields of a Discovery dependency template and returns the updated template.
Fields not given are unchanged.
Built-in templates cannot be changed (the server returns an error; CanEdit is false on them).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryDependencyTemplate -TssSession $session -Id 12 -SecretDependencyTemplateDescription 'App pools on the web farm'
```

Change the description of dependency template 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryDependencyTemplate -TssSession $session -Id 12 -Active:$false
```

Deactivate dependency template 12

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
Dependency template id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Activate the template; use -Active:$false to deactivate it

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

Required: False
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretDependencyTypeId
Dependency type id

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

### Thycotic.PowerShell.Discovery.DependencyTemplate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyTemplate.ps1)
