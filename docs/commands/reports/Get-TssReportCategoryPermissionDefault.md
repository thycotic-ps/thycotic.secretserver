---
title: Get-TssReportCategoryPermissionDefault
parent: Reports
grand_parent: Commands
---
# Get-TssReportCategoryPermissionDefault

## SYNOPSIS
Get the report permissions a report category passes down

## SYNTAX

```
Get-TssReportCategoryPermissionDefault [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the permissions a report inherits from a report category: the permissions a report in that category gets when it inherits permissions.
Returns up to the session's Take value of entries per category.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReportCategoryPermissionDefault -TssSession $session -Id 3
```

Returns the permissions a report placed in report category 3 inherits

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
Type: Int32[]
Parameter Sets: (All)
Aliases: ReportCategoryId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Reports.Permission[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategoryPermissionDefault](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportCategoryPermissionDefault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategoryPermissionDefault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportCategoryPermissionDefault.ps1)
