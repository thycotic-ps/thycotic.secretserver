# New-TssMetadataField

## SYNOPSIS
Create a metadata field for an item

## SYNTAX

### newsection
```
New-TssMetadataField [-TssSession] <Session> -ItemId <Int32> -ItemType <MetadataType> [-SectionName <String>]
 [-SectionDescription <String>] -FieldName <String> -FieldDataType <MetadataFieldDataType> -FieldValue <Object>
 [-RequireAdminister] [-RequireItemEdit] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### currentsection
```
New-TssMetadataField [-TssSession] <Session> -ItemId <Int32> -ItemType <MetadataType> [-SectionId <Int32>]
 -FieldName <String> -FieldDataType <MetadataFieldDataType> -FieldValue <Object> [-RequireAdminister]
 [-RequireItemEdit] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a metadata field for an item

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newMetaParams = @{
    TssSession = $session
    ItemId = 5
    ItemType = 'User'
    SectionId = 1
    FieldName = 'DeleteMeOn'
    FieldDataType = 'DateTime'
    FieldValue = '2021-12-31 11:59:59 PM'
}
New-TssMetadataField @newMetaParams
```

Create the metadata field DeleteMeOn with a DateTime value of December 31, 2021 11:59:59 PM on User ID 5, in current Field Section ID 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newMetaParams = @{
    TssSession = $session
    ItemId = 5
    ItemType = 'User'
    SectionName = 'TempInfo'
    SectionDescription = 'Information that is temporary'
    FieldName = 'CurrentOwner'
    FieldDataType = 'User'
    FieldValue = 6
}
New-TssMetadataField @newMetaParams
```

Create the metadata field CurrentOwner with a User ID set to 6, under new section called "TempInfo" (with a description)

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

### -SectionId
Field Section ID

```yaml
Type: Int32
Parameter Sets: currentsection
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionName
Field Section Name

```yaml
Type: String
Parameter Sets: newsection
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionDescription
Field Section Description

```yaml
Type: String
Parameter Sets: newsection
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldName
Field Name

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

### -FieldDataType
Field Data Type

```yaml
Type: MetadataFieldDataType
Parameter Sets: (All)
Aliases:
Accepted values: String, Boolean, Number, DateTime, User

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldValue
Item Value

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.Metadata.Field
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataField](https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataField.ps1)

