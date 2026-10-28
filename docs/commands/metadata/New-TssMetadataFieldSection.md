---
title: New-TssMetadataFieldSection
parent: Metadata
grand_parent: Commands
---
# New-TssMetadataFieldSection

## SYNOPSIS
Create a metadata field section

## SYNTAX

```
New-TssMetadataFieldSection [-TssSession] <Session> -SectionName <String> [-SectionDescription <String>]
 [-RequireAdminister] [-RequireItemEdit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a metadata field section (POST metadata/field-sections).
Add field definitions to the section with New-TssMetadataField -SectionId.
Requires the Administer Metadata permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssMetadataFieldSection -TssSession $session -SectionName 'Ownership' -SectionDescription 'Who owns the item'
```

Create the metadata field section Ownership

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$section = New-TssMetadataFieldSection -TssSession $session -SectionName 'Compliance' -RequireAdminister
New-TssMetadataField -TssSession $session -SectionId $section.MetadataFieldSectionId -FieldName 'ReviewedOn' -FieldDataType DateTime
```

Create the section Compliance that only users with Administer Metadata can change, then add a DateTime field to it

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

### -SectionName
Name of the metadata field section

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

### -SectionDescription
Description of the metadata field section

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

### -RequireAdminister
Require the Administer Metadata permission to modify metadata in this section

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

### -RequireItemEdit
Require Edit permission on the item to modify metadata in this section

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

### Thycotic.PowerShell.Metadata.FieldSectionSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataFieldSection](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataFieldSection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataFieldSection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataFieldSection.ps1)
