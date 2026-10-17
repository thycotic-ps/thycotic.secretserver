---
title: New-TssReportCategory
parent: Reports
grand_parent: Commands
---
# New-TssReportCategory

## SYNOPSIS
Create a new report category

## SYNTAX

```
New-TssReportCategory [-TssSession] <Session> -Name <String> -Description <String> [-SortOrder <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new report category.
Without SortOrder the category is added at the end of the category list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssReportCategory -TssSession $session -Name 'Audit Reports' -Description 'Reports for the audit team'
```

Creates the report category "Audit Reports" at the end of the category list

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssReportCategory -TssSession $session -Name 'Rotation' -Description 'Password rotation reports' -SortOrder 1
```

Creates the report category "Rotation" with sort order 1

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

### -Name
Name of the report category

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReportCategoryName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
Description of the report category

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReportCategoryDescription

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SortOrder
Position of the category in the category list

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Reports.CategoryDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/New-TssReportCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/New-TssReportCategory.ps1)
