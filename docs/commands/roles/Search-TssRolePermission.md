---
title: Search-TssRolePermission
parent: Roles
grand_parent: Commands
---
# Search-TssRolePermission

## SYNOPSIS
Search the permissions of a role

## SYNTAX

### Default (Default)
```
Search-TssRolePermission [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Eligible
```
Search-TssRolePermission [-TssSession] <Session> -Id <Int32[]> [-Eligible]
 [<CommonParameters>]
```

### Unassigned
```
Search-TssRolePermission [-TssSession] <Session> -Id <Int32[]> [-Unassigned]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the permissions assigned to a role.
With -Eligible, returns every permission the role type allows.
With -Unassigned, returns the allowed permissions the role does not have.
Pass RolePermissionId values to Update-TssRolePermission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRolePermission -TssSession $session -Id 7
```

Returns the permissions assigned to role ID 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRolePermission -TssSession $session -Id 7 -Unassigned
```

Returns the permissions role ID 7 could have but does not

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
Type: Int32[]
Parameter Sets: (All)
Aliases: RoleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Eligible
Return every permission the role type allows (GET api/v1/roles/{id}/permissions/eligible)

```yaml
Type: SwitchParameter
Parameter Sets: Eligible
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unassigned
Return the permissions the role type allows that the role does not have (GET api/v1/roles/{id}/permissions/unassigned)

```yaml
Type: SwitchParameter
Parameter Sets: Unassigned
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

### Thycotic.PowerShell.Roles.Permission[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRolePermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRolePermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRolePermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRolePermission.ps1)
