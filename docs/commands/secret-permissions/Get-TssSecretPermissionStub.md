---
title: Get-TssSecretPermissionStub
parent: Secret Permissions
grand_parent: Commands
---
# Get-TssSecretPermissionStub

## SYNOPSIS
Get the default values for a new secret permission

## SYNTAX

```
Get-TssSecretPermissionStub [-TssSession] <Session> -SecretId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Get the default values for a new secret permission on a secret (permission ID 0, no user or group, default secret role).
Nothing is saved; use New-TssSecretPermission to add the permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPermissionStub -TssSession $session -SecretId 76
```

Returns the default secret permission values for secret 76

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSecretPermissionStub -TssSession $session -SecretId 76).SecretAccessRoleName
```

Returns the secret role a new permission on secret 76 gets by default

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

### -SecretId
Secret ID the new permission is for

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionStub.ps1)
