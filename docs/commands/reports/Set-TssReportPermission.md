---
title: Set-TssReportPermission
parent: Reports
grand_parent: Commands
---
# Set-TssReportPermission

## SYNOPSIS
Set the permissions of a report

## SYNTAX

### inherit (Default)
```
Set-TssReportPermission [-TssSession] <Session> -Id <Int32> [-EnableInheritPermissions] [-AllowRemoveEdit]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### grant
```
Set-TssReportPermission [-TssSession] <Session> -Id <Int32> -GroupId <Int32[]> -RolePermissionId <Int32[]>
 [-EnableInheritPermissions] [-AllowRemoveEdit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### clear
```
Set-TssReportPermission [-TssSession] <Session> -Id <Int32> [-Clear] [-EnableInheritPermissions]
 [-AllowRemoveEdit] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the explicit permissions of a report, or whether it inherits permissions from its report category.
The permissions given replace the report's whole permission list; Clear removes every explicit permission.
Each GroupId gets the matching RolePermissionId, or the single RolePermissionId when only one is given.
Turning inheritance on also removes every explicit permission from the report.
Use Search-TssReportPermission -Options for the role permission IDs.
Returns the permissions of the report after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReportPermission -TssSession $session -Id 60 -EnableInheritPermissions
```

Makes report 60 inherit permissions from its report category and removes its explicit permissions

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$view = Search-TssReportPermission -TssSession $session -Options | Where-Object RolePermissionName -like '*View*'
Set-TssReportPermission -TssSession $session -Id 60 -GroupId 25 -RolePermissionId $view.RolePermissionId -EnableInheritPermissions:$false -AllowRemoveEdit
```

Stops report 60 inheriting permissions and replaces its permissions with the view permission for group 25

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
Report ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ReportId

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
Remove every explicit permission from the report

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

### -EnableInheritPermissions
Inherit permissions from the report category, which removes the explicit permissions; -EnableInheritPermissions:$false stops inheriting

```yaml
Type: SwitchParameter
Parameter Sets: inherit
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: grant, clear
Aliases:

Required: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Set-TssReportPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Set-TssReportPermission.ps1)
