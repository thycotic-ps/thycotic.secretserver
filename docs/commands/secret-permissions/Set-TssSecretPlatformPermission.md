---
title: Set-TssSecretPlatformPermission
parent: Secret Permissions
grand_parent: Commands
---
# Set-TssSecretPlatformPermission

## SYNOPSIS
Grant a platform service account a role on a secret

## SYNTAX

```
Set-TssSecretPlatformPermission [-TssSession] <Session> -SecretId <Int32> -Username <String>
 -AccessRole <SecretPermissions> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Grant a platform service account a secret access role on a secret.
Nothing changes when the account already has the role.
Success is false, with the reason in Message, when the account is not a platform service account (always so on a Secret Server not connected to the Delinea Platform).
Success is false and Message is empty when the secret needs check out, double lock, a comment or approval for access, or when the grant fails.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretPlatformPermission -TssSession $session -SecretId 42 -Username svc-reporting -AccessRole View
```

Grants platform service account svc-reporting View on secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretPlatformPermission -TssSession $session -SecretId 42 -Username svc-reporting -AccessRole Edit -WhatIf
```

Shows the request that would grant Edit without sending it

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
Secret ID

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

### -Username
Username of the platform service account

```yaml
Type: String
Parameter Sets: (All)
Aliases: PlatformUserName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessRole
Secret access role to grant (List, View, Edit, Owner)

```yaml
Type: SecretPermissions
Parameter Sets: (All)
Aliases: AclRoleName
Accepted values: List, View, Edit, Owner

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

### Thycotic.PowerShell.SecretPermissions.PlatformPermission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPlatformPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPlatformPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Set-TssSecretPlatformPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Set-TssSecretPlatformPermission.ps1)
