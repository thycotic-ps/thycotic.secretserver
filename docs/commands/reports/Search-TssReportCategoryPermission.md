---
title: Search-TssReportCategoryPermission
parent: Reports
grand_parent: Commands
---
# Search-TssReportCategoryPermission

## SYNOPSIS
Search the permissions of a report category

## SYNTAX

### category (Default)
```
Search-TssReportCategoryPermission [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### options
```
Search-TssReportCategoryPermission [-TssSession] <Session> [-Options]
 [<CommonParameters>]
```

## DESCRIPTION
Search the permissions of a report category: each entry is a user or group and the role permission it holds on the category.
With Options it lists the role permissions that can be granted on a report category instead.
Returns up to the session's Take value of entries per category.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportCategoryPermission -TssSession $session -Id 3
```

Returns the permissions of report category 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssReportCategoryPermission -TssSession $session -Options
```

Returns the role permissions (RolePermissionId and RolePermissionName) that can be granted on a report category

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
Parameter Sets: category
Aliases: ReportCategoryId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Options
List the role permissions that can be granted on a report category

```yaml
Type: SwitchParameter
Parameter Sets: options
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Reports.Permission[]
### Thycotic.PowerShell.Reports.PermissionOption[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportCategoryPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Search-TssReportCategoryPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportCategoryPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Search-TssReportCategoryPermission.ps1)
