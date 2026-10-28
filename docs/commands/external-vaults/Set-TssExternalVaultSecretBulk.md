---
title: Set-TssExternalVaultSecretBulk
parent: External Vaults
grand_parent: Commands
---
# Set-TssExternalVaultSecretBulk

## SYNOPSIS
Set properties of several external vault secrets

## SYNTAX

```
Set-TssExternalVaultSecretBulk [-TssSession] <Session> [-Active] [-EnableInheritPermissions]
 [-LinkedSecretId <Int32>] [-Transform <String>] -ExternalVaultSecretId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the same properties on several external vault secrets in one request.
Only the parameters passed are changed.
The output lists one result per external vault secret, with the updated secret or the error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultSecretBulk -TssSession $session -ExternalVaultSecretId 12, 13, 14 -Active:$false
```

Make external vault secrets 12, 13 and 14 inactive

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

### -Active
Make the external vault secrets active (-Active) or inactive (-Active:$false)

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

### -EnableInheritPermissions
Inherit permissions from the external vault (-EnableInheritPermissions) or not (-EnableInheritPermissions:$false)

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

### -LinkedSecretId
ID of the Secret Server secret to link

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Transform
Template evaluated at push time to build the value sent to the external vault, for example '$PASSWORD'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalVaultSecretId
IDs of the external vault secrets to change

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

### Thycotic.PowerShell.ExternalVaults.SecretBulk
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretBulk](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretBulk)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretBulk.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretBulk.ps1)
