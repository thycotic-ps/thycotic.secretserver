# Update-TssMetadataSection

## SYNOPSIS
Update metadata field section

## SYNTAX

```
Update-TssMetadataSection [-TssSession] <Session> -SectionId <Int32> -ItemId <Int32> -ItemType <MetadataType>
 [-Name <String>] [-Description <String>] [-RequireAdminister] [-RequireItemEdit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update metadata field section

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMetadata -TssSession -ItemId 5 -ItemType User
Update-TssMetadataSection -TssSession $session -SectionId 5 -ItemType User -ItemDataId 5 -FieldValue 2
```

Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
Update the value to 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMetadata -TssSession -ItemId 5 -ItemType User
Update-TssMetadataSection -TssSession $session -ItemId 5 -ItemType User -ItemDataId 5 -FieldValue 2
```

Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
Update the value to 2

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

### -SectionId
Field Section ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FieldSectionId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemId
Item ID

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

### -ItemType
Item Type

```yaml
Type: MetadataType
Parameter Sets: (All)
Aliases:
Accepted values: Secret, User, Folder, Group

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Field Section Name

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

### -Description
Field Section description

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
Requires Administer Metadata permission to modify

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
Requires Edit permission on the Item to modify

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssMetadataSection](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssMetadataSection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssMetadataSection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssMetadataSection.ps1)

