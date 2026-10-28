---
title: Set-TssSecretTemplateField
parent: Secret Templates
grand_parent: Commands
---
# Set-TssSecretTemplateField

## SYNOPSIS
Set properties of a secret template field

## SYNTAX

```
Set-TssSecretTemplateField [-TssSession] <Session> -Id <Int32> [-Active] [-DataType <String>]
 [-Description <String>] [-DropdownOptionsToAdd <String[]>] [-DropdownOptionsToRemove <Object[]>]
 [-DropdownOptionsToUpdate <Object[]>] [-EditRequiresPermission <String>] [-ExposeForDisplay]
 [-HistoryLength <Int32>] [-Name <String>] [-PasswordRequirement <Int32>] [-Required] [-SaveAllHistory]
 [-Searchable] [-SlugName <String>] [-SortOrder <Int32>] [-ViewingRequiresEdit]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes one or more properties of a secret template field.
Only the parameters you pass are changed.
Returns the updated field.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretTemplateField -TssSession $session -Id 312 -Description 'Owner of the service account' -Searchable
```

Change the description of field 312 and make it searchable

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretTemplateField -TssSession $session -Id 314 -DropdownOptionsToAdd 'Production', 'Staging'
```

Add two dropdown options to list field 314

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
Secret template field ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretTemplateFieldId, FieldId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Set the field active, or inactive with -Active:$false

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

### -DataType
Field data type.
Rarely changed after secrets use the field

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
Field description

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

### -DropdownOptionsToAdd
Values to add to the dropdown options of a list field

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DropdownOptionsToRemove
Dropdown options to remove: objects with id and value properties, as in the DropdownOptions of Get-TssSecretTemplateField

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

### -DropdownOptionsToUpdate
Dropdown options to change: objects with the id of an existing option and its new value

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

### -EditRequiresPermission
Permission a user needs to edit the field value

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

### -ExposeForDisplay
Expose the field value for display, or hide it with -ExposeForDisplay:$false

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
Number of previous values to keep.
Ignored when SaveAllHistory is set

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

### -Name
Display name of the field

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

### -PasswordRequirement
Password requirement ID for a password field

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

### -Required
Make the field required, or optional with -Required:$false

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

### -SaveAllHistory
Keep every previous value of the field

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

### -Searchable
Make the field searchable, or not with -Searchable:$false

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

### -SlugName
Slug name that scripts and the API use to reference the field.
Changing it breaks scripts that use the old slug

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

### -SortOrder
Position of the field on the template

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

### -ViewingRequiresEdit
Require edit permission to view the field value

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

### Thycotic.PowerShell.SecretTemplates.FieldDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateField.ps1)
