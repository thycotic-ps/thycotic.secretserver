# Search-TssMetadataSection

## SYNOPSIS
Search Metadata Field Section that has metadata for a specific item

## SYNTAX

### item
```
Search-TssMetadataSection [-TssSession] <Session> -ItemId <Int32> -ItemType <MetadataType> [-SortBy <String>]
 [<CommonParameters>]
```

### field
```
Search-TssMetadataSection [-TssSession] <Session> [-SectionFieldId <Int32>] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search Metadata Field Section that has metadata for a specific item

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMetadataSection -TssSession $session -ItemId 5
```

Return field sections for Item ID 5

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
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemId
Item ID to return metadata

```yaml
Type: Int32
Parameter Sets: item
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionFieldId
Metadata Field ID

```yaml
Type: Int32
Parameter Sets: field
Aliases: MetadataSectionFieldId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemType
Item Type (Secret, User, Folder, Group)

```yaml
Type: MetadataType
Parameter Sets: item
Aliases: MetadataType
Accepted values: Secret, User, Folder, Group

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default ItemId

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ItemId
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataSection](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataSection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataSection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataSection.ps1)

