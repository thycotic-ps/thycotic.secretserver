---
title: Test-TssSecretOwner
parent: Secret Permissions
grand_parent: Commands
---
# Test-TssSecretOwner

## SYNOPSIS
Test whether you would still own a secret with the given permissions

## SYNTAX

```
Test-TssSecretOwner [-TssSession] <Session> -GroupId <Int32[]> -SecretAccessRoleId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Test whether the current user would be an owner of a secret if its permissions were the given groups and secret access roles.
Returns true or false.
Nothing is saved.
Use it before replacing the permissions on a secret, so you do not remove your own owner access.
Role IDs come from Get-TssSecretPermissionRoleOption.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$owner = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq Owner).Id
Test-TssSecretOwner -TssSession $session -GroupId 3 -SecretAccessRoleId $owner
```

Returns true when Owner for group 3 would keep you an owner

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$owner = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq Owner).Id
$view = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq View).Id
Test-TssSecretOwner -TssSession $session -GroupId 3, 12 -SecretAccessRoleId $view, $owner
```

Tests a set of two group permissions, View for group 3 and Owner for group 12

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

### -GroupId
Group IDs of the proposed secret permissions

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretAccessRoleId
Secret access role IDs of the proposed secret permissions: one ID for every group, or one per group in the same order as GroupId

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Test-TssSecretOwner](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Test-TssSecretOwner)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Test-TssSecretOwner.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Test-TssSecretOwner.ps1)
