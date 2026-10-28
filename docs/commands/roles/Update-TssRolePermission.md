---
title: Update-TssRolePermission
parent: Roles
grand_parent: Commands
---
# Update-TssRolePermission

## SYNOPSIS
Replace the permissions assigned to a role

## SYNTAX

```
Update-TssRolePermission [-TssSession] <Session> -Id <Int32> -RolePermissionId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the full list of permissions on a role.
Permissions not in the list are removed from the role, so pass every permission the role should keep.
An empty list removes every permission.
Get role permission IDs from Search-TssRolePermission with -ErrorAction Stop and the default session Take: a failed or partial read gives a short list, and every permission missing from it is removed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$ids = @((Search-TssRolePermission -TssSession $session -Id 7 -ErrorAction Stop).RolePermissionId)
$ids += (Search-TssRolePermission -TssSession $session -Id 7 -Unassigned -ErrorAction Stop | Where-Object Name -eq 'View Roles').RolePermissionId
Update-TssRolePermission -TssSession $session -Id 7 -RolePermissionId $ids
```

Adds the View Roles permission to role ID 7 and keeps the permissions it already has

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
Role ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RolePermissionId
Every role permission ID the role should have after the call

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: RolePermissionIds

Required: True
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

### Thycotic.PowerShell.Roles.UpdateResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Update-TssRolePermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Update-TssRolePermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Update-TssRolePermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Update-TssRolePermission.ps1)
