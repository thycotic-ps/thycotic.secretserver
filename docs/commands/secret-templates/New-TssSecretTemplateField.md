# New-TssSecretTemplateField

## SYNOPSIS
Create a new field object for the TssSecretTemplate object

## SYNTAX

```
New-TssSecretTemplateField [-FieldName] <String> [-Type <TemplateFieldTypes>] [-EditRequire <String>]
 [-Description <String>] [-IsRequired] [-ViewRequiresEdit] [-HistoryLength <Int32>] [-Searchable]
 [-ExposeForDisplay] [-SortOrder <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Create a new field object for the TssSecretTemplate object

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
(Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
$newField = New-TssSecretTemplateField -FieldName 'Additional Field' -Searchable
Add-TssSecretTemplateField -TssSession $session -Id 6042 -Field $newField
(Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
```

Output the current fields for Secret Template 6042, create a new field named "Additional Field" that is searchable and add to the Secret Template 6042

### EXAMPLE 2
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
$copyTemplate = Get-TssSecretTemplate -TssSession $session -Id 6042
$copyTemplate.Name = 'Test Template - copy of 6042'
New-TssSecretTemplate -TssSession $session -Template $copyTemplate
```

Gets the Secret Template 6042, changing the name of the Template and then creating it.

### EXAMPLE 3
```
$session = New-TssSession 'https://alpha/SecretServer' $ssCred
$fields = @()
$fields += New-TssSecretTemplateField -FieldName 'Field 1 Username' -Searchable
$fields += New-TssSecretTemplateField -FieldName 'Field 2 Password' -Type Password
$fields += New-TssSecretTemplateField -FieldName 'Field 3 URL' -Type Url -Searchable
New-TssSecretTemplate -TssSession $session -TemplateName 'Test Template 42' -TemplateField $fields
```

Creates a new template named "Test Template 42" with 3 fields

## PARAMETERS

### -FieldName
Field Name - value used for DisplayName, Name, and Slug Name

```yaml
Type: String
Parameter Sets: (All)
Aliases: Field

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Field Type: Notes, Text, File, Url, or Password

```yaml
Type: TemplateFieldTypes
Parameter Sets: (All)
Aliases:
Accepted values: Notes, Text, File, Url, Password

Required: False
Position: Named
Default value: Text
Accept pipeline input: False
Accept wildcard characters: False
```

### -EditRequire
Edit permission: Owner, Edit, NotEditable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Edit
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Field description, defaults to null

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

### -IsRequired
Field is required

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

### -ViewRequiresEdit
Viewing requires edit (HideOnView)

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

### -HistoryLength
History length for the field, defaults to max (All)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2147483647
Accept pipeline input: False
Accept wildcard characters: False
```

### -Searchable
Field values are searchable (IsIndexable)

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

### -ExposeForDisplay
Field is exposed for display (not encrypted)

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

### -SortOrder
Field order

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretTemplates.Field
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateStubField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateStubField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateStubField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateStubField.ps1)

