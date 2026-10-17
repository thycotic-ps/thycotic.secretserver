---
title: Search-TssSecretTemplatePermissionRole
parent: Secret Template Permissions
grand_parent: Commands
---
# Search-TssSecretTemplatePermissionRole

## SYNOPSIS
Get the roles that can be assigned on secret templates

## SYNTAX

```
Search-TssSecretTemplatePermissionRole [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret template permission roles, such as Template Owner and Template Create Secret, with their role IDs.
Use a RoleId with Update-TssSecretTemplatePermission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretTemplatePermissionRole -TssSession $session
```

List the secret template permission roles

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

### Thycotic.PowerShell.SecretTemplatePermissions.Role[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermissionRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermissionRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermissionRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermissionRole.ps1)
