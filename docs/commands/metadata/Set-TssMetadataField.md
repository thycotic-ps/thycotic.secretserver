---
title: Set-TssMetadataField
parent: Metadata
grand_parent: Commands
---
# Set-TssMetadataField

## SYNOPSIS
Rename or disable a metadata field definition

## SYNTAX

```
Set-TssMetadataField [-TssSession] <Session> -Id <Int32> [-Enabled] [-FieldName <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Rename or disable a metadata field definition (PATCH metadata/fields/{id}).
Only the parameters you give are sent; omitted settings stay unchanged.
A disabled field keeps its values on items, and Search-TssMetadata still returns them. Secret Server rejects enabling it again.
Requires the Administer Metadata permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssMetadataField -TssSession $session -Id 12 -FieldName 'CostCenter'
```

Rename metadata field 12 to CostCenter

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMetadataField -TssSession $session | Where-Object MetadataFieldName -eq 'DeleteMeOn' | Set-TssMetadataField -TssSession $session -Enabled:$false
```

Disable the metadata field named DeleteMeOn, found with Get-TssMetadataField

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
Metadata field ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FieldId, MetadataFieldId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Enabled
Disable the field with -Enabled:$false; omit to leave it unchanged.
A disabled field cannot be enabled again

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

### -FieldName
New name for the metadata field

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

### Thycotic.PowerShell.Metadata.FieldSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Set-TssMetadataField](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Set-TssMetadataField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Set-TssMetadataField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Set-TssMetadataField.ps1)
