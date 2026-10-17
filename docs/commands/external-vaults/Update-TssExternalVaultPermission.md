---
title: Update-TssExternalVaultPermission
parent: External Vaults
grand_parent: Commands
---
# Update-TssExternalVaultPermission

## SYNOPSIS
Update the permissions of an external vault

## SYNTAX

```
Update-TssExternalVaultPermission [-TssSession] <Session> -Id <Int32> [-Permission <Permission[]>]
 [-RemoveGroupId <Int32[]>] [-RemoveUserId <Int32[]>] [-CanRemoveSelfAccess]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add, change or remove user and group permissions on an external vault.
Permissions not passed are left as they are.
-Permission takes the records Search-TssExternalVaultPermission returns, edited, or new ones built from the Permission type with a GroupId or a UserId.
Every permission flag of a record is sent, so a flag left false is removed.
The output is True when the server applied the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$permission = Search-TssExternalVaultPermission -TssSession $session -Id 3 -SearchText 'Vault Admins'
$permission.EditVault = $true
Update-TssExternalVaultPermission -TssSession $session -Id 3 -Permission $permission
```

Give the Vault Admins group the EditVault permission on external vault 3, keeping its other permissions

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$permission = [Thycotic.PowerShell.ExternalVaults.Permission]@{ GroupId = 7; ViewExternalSecret = $true }
Update-TssExternalVaultPermission -TssSession $session -Id 3 -Permission $permission
```

Give group 7 the ViewExternalSecret permission on external vault 3

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssExternalVaultPermission -TssSession $session -Id 3 -RemoveGroupId 7
```

Remove the permissions of group 7 from external vault 3

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
External vault ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ExternalVaultId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Permission
Permissions to add or change, as returned by Search-TssExternalVaultPermission

```yaml
Type: Permission[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveGroupId
IDs of groups whose permissions to remove

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveUserId
IDs of users whose permissions to remove

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CanRemoveSelfAccess
Allow the update to remove your own access

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Update-TssExternalVaultPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Update-TssExternalVaultPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Update-TssExternalVaultPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Update-TssExternalVaultPermission.ps1)
