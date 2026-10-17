---
title: Remove-TssMetadataField
parent: Metadata
grand_parent: Commands
---
# Remove-TssMetadataField

## SYNOPSIS
Disable a metadata field definition

## SYNTAX

```
Remove-TssMetadataField [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disable a metadata field definition (DELETE metadata/fields/{id}).
Values already set on items are kept, and Search-TssMetadata still returns them.
This cannot be undone.
Requires the Administer Metadata permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssMetadataField -TssSession $session -Id 12
```

Disable metadata field 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMetadataField -TssSession $session | Where-Object MetadataFieldName -eq 'DeleteMeOn' | Remove-TssMetadataField -TssSession $session -Confirm:$false
```

Disable the metadata field named DeleteMeOn without a confirmation prompt

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
Type: Int32[]
Parameter Sets: (All)
Aliases: FieldId, MetadataFieldId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Remove-TssMetadataField](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Remove-TssMetadataField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Remove-TssMetadataField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Remove-TssMetadataField.ps1)
