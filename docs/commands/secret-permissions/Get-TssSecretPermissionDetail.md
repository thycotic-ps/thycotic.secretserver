---
title: Get-TssSecretPermissionDetail
parent: Secret Permissions
grand_parent: Commands
---
# Get-TssSecretPermissionDetail

## SYNOPSIS
Get a secret permission by ID

## SYNTAX

```
Get-TssSecretPermissionDetail [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get a single secret permission by its secret permission ID.
Search-TssSecretPermission lists the permissions on a secret; this returns one of them.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPermissionDetail -TssSession $session -Id 1043
```

Returns secret permission 1043

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretPermission -TssSession $session -SecretId 76 | Get-TssSecretPermissionDetail -TssSession $session
```

Returns each permission on secret 76 by its ID

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
Secret permission ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretPermissionId

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

### Thycotic.PowerShell.SecretPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionDetail](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionDetail)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionDetail.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionDetail.ps1)
