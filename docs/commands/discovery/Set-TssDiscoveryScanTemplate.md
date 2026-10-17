---
title: Set-TssDiscoveryScanTemplate
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoveryScanTemplate

## SYNOPSIS
Update a Discovery scan template

## SYNTAX

```
Set-TssDiscoveryScanTemplate [-TssSession] <Session> -Id <Int32> [-AccountScanId <Int32>]
 [-AccountScanIds <Int32[]>] [-Fields <Object[]>] [-IsActive] [-ParentScanTemplateId <Int32>]
 [-ScanTemplateName <String>] [-ScanTypeId <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the given fields of a Discovery scan template and returns the updated template.
Fields not given are unchanged.
Fields replaces every field of the template.
Use it on templates you created: the server does not stop changes to built-in templates.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryScanTemplate -TssSession $session -Id 31 -ScanTemplateName 'Local Account (renamed)'
```

Rename scan template 31

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoveryScanTemplate -TssSession $session -Id 31 -IsActive:$false
```

Deactivate scan template 31

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
Scan template id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScanTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountScanId
Deprecated, use AccountScanIds.
Account scan template id for a dependency template (scan type 4)

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

### -AccountScanIds
Account scan template ids, for a dependency template (scan type 4)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
Every field of the template (replaces the current fields): hashtables or objects with scanItemFieldId (omit for a new field), scanItemFieldName, parentScanItemFieldId and includeInMatch

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

### -IsActive
Activate the template; use -IsActive:$false to deactivate it

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

### -ParentScanTemplateId
Parent scan template id

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

### -ScanTemplateName
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

### -ScanTypeId
Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

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

### Thycotic.PowerShell.Discovery.ScanTemplate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryScanTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryScanTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryScanTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryScanTemplate.ps1)
