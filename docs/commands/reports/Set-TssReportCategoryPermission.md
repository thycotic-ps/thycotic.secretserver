---
title: Set-TssReportCategoryPermission
parent: Reports
grand_parent: Commands
---
# Set-TssReportCategoryPermission

## SYNOPSIS
Set the permissions of a report category

## SYNTAX

### grant (Default)
```
Set-TssReportCategoryPermission [-TssSession] <Session> -Id <Int32> -GroupId <Int32[]>
 -RolePermissionId <Int32[]> [-AllowRemoveEdit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### clear
```
Set-TssReportCategoryPermission [-TssSession] <Session> -Id <Int32> [-Clear] [-AllowRemoveEdit]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the explicit permissions of a report category.
The permissions given replace the category's whole permission list; Clear removes every explicit permission.
Each GroupId gets the matching RolePermissionId, or the single RolePermissionId when only one is given.
Use Search-TssReportCategoryPermission -Options for the role permission IDs.
Returns the permissions of the category after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$view = Search-TssReportCategoryPermission -TssSession $session -Options | Where-Object RolePermissionName -like '*View*'
Set-TssReportCategoryPermission -TssSession $session -Id 3 -GroupId 25, 79 -RolePermissionId $view.RolePermissionId -AllowRemoveEdit
```

Replaces the permissions of report category 3 with the view permission for groups 25 and 79

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportCategoryPermission -TssSession $session -Id 3 -Clear -AllowRemoveEdit
```

Removes every explicit permission from report category 3

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

### -GroupId
Group IDs (a user's personal group for a user) to grant a permission

```yaml
Type: Int32[]
Parameter Sets: grant
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RolePermissionId
Role permission ID for each GroupId, or one ID for all of them

```yaml
Type: Int32[]
Parameter Sets: grant
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear
Remove every explicit permission from the report category

```yaml
Type: SwitchParameter
Parameter Sets: clear
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowRemoveEdit
Allow the change to remove the edit permission of the current user

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

### Thycotic.PowerShell.Reports.Permission[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategoryPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportCategoryPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategoryPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportCategoryPermission.ps1)
