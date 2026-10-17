---
title: Get-TssRoleUnassignedPermission
parent: Roles
grand_parent: Commands
---
# Get-TssRoleUnassignedPermission

## SYNOPSIS
Get the permissions not assigned to any role

## SYNTAX

```
Get-TssRoleUnassignedPermission [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the name of every permission that no role has, one string per permission.
Secret Server never returns Web Services Impersonate or the four Privilege Manager permissions here, even when no role has them.
Useful after an upgrade to find new permissions that no role has been given yet.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRoleUnassignedPermission -TssSession $session
```

Returns the names of permissions no role has

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRoleUnassignedPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRoleUnassignedPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRoleUnassignedPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRoleUnassignedPermission.ps1)
