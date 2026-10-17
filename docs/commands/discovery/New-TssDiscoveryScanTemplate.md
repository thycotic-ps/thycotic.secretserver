---
title: New-TssDiscoveryScanTemplate
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoveryScanTemplate

## SYNOPSIS
Create a Discovery scan template

## SYNTAX

```
New-TssDiscoveryScanTemplate [-TssSession] <Session> [-AccountScanId <Int32>] [-AccountScanIds <Int32[]>]
 [-CreateDefaultFields] [-Fields <Object[]>] [-IsActive] [-ParentScanTemplateId <Int32>]
 -ScanTemplateName <String> -ScanTypeId <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a Discovery scan template and returns it.
With CreateDefaultFields and no Fields, the template takes its fields from the parent template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoveryScanTemplate -TssSession $session -ScanTemplateName 'Local Account (custom)' -ScanTypeId 3 -ParentScanTemplateId 1 -CreateDefaultFields -IsActive
```

Create an active local account scan template that copies the fields of template 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoveryScanTemplate -TssSession $session -ScanTemplateName 'Local Account (two fields)' -ScanTypeId 3 -ParentScanTemplateId 1 -IsActive -Fields @{ scanItemFieldName = 'Username'; parentScanItemFieldId = 1; includeInMatch = $true }, @{ scanItemFieldName = 'Machine'; parentScanItemFieldId = 2; includeInMatch = $true }
```

Create an active local account scan template with two fields

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

### -CreateDefaultFields
Copy the fields of the parent template when Fields is not given.
The server rejects a template without fields, so give CreateDefaultFields with ParentScanTemplateId, or Fields

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

### -Fields
Template fields: hashtables or objects with scanItemFieldName, parentScanItemFieldId and includeInMatch (include the field when matching scanned items)

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

Required: True
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

### Thycotic.PowerShell.Discovery.ScanTemplate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanTemplate.ps1)
