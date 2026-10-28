---
title: Get-TssSecretPermissionRoleOption
parent: Secret Permissions
grand_parent: Commands
---
# Get-TssSecretPermissionRoleOption

## SYNOPSIS
Get the roles that can be granted on a secret

## SYNTAX

```
Get-TssSecretPermissionRoleOption [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the secret access roles (List, View, Edit, Owner) that can be granted on a secret, and which one is the default.
One object is returned per role.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPermissionRoleOption -TssSession $session
```

Returns every secret access role

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object IsDefault
```

Returns the default secret access role

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

### Thycotic.PowerShell.SecretPermissions.RoleOption[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionRoleOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionRoleOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionRoleOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionRoleOption.ps1)
