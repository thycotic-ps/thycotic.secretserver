---
title: Set-TssReportCategory
parent: Reports
grand_parent: Commands
---
# Set-TssReportCategory

## SYNOPSIS
Set the name or description of a report category

## SYNTAX

```
Set-TssReportCategory [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the name or description of a report category.
Only the parameters provided are changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportCategory -TssSession $session -Id 12 -Description 'Reports for the audit team'
```

Sets the description of report category 12, leaving its name unchanged

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportCategory -TssSession $session -Id 12 -Name 'Audit' -Description 'Reports for the audit team'
```

Renames report category 12 to "Audit" and sets its description

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
Report category ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ReportCategoryId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New name of the report category

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReportCategoryName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
New description of the report category

```yaml
Type: String
Parameter Sets: (All)
Aliases: ReportCategoryDescription

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

### Thycotic.PowerShell.Reports.CategoryDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategory.ps1)
