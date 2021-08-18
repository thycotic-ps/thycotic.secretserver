# Search-TssMetadataHistory

## SYNOPSIS
Search metadata history

## SYNTAX

### item
```
Search-TssMetadataHistory [-TssSession] <Session> -ItemId <Int32> -ItemType <MetadataType> [-EndDate <String>]
 [-StartDate <String>] [-SortBy <String>] [<CommonParameters>]
```

### field
```
Search-TssMetadataHistory [-TssSession] <Session> [-FieldId <Int32>] [-EndDate <String>] [-StartDate <String>]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search metadata history

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssMetadataHistory -TssSession $session -ItemId 5 -ItemType User
```

Returns history of all metadata fields for User ID5

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

### -FieldId
Metadata Field ID

```yaml
Type: Int32
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Return history only entered before this time

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

### -StartDate
Return history only entered after this time

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

### Thycotic.PowerShell.Metadata.History
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataHistory.ps1)

