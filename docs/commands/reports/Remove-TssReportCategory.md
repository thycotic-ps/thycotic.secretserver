# Remove-TssReportCategory

## SYNOPSIS
Delete a report category

## SYNTAX

```
Remove-TssReportCategory [-TssSession] <Session> -ReportCategoryId <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes the report category, associated reports are changed to inactive and moved to the Delete category

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssReportCategory -TssSession $session -Id 11
```

A confirmation prompt will be shown.
Removes report category 11

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssReportCategory -TssSession $session -Id 21 -Confirm:$false
```

Confirmation prompt is bypassed
Removes report category 21

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

### -ReportCategoryId
Category ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Remove-TssReportCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Remove-TssReportCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Remove-TssReportCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Remove-TssReportCategory.ps1)

