---
title: Set-TssExternalVaultSecret
parent: External Vaults
grand_parent: Commands
---
# Set-TssExternalVaultSecret

## SYNOPSIS
Set properties of an external vault secret

## SYNTAX

```
Set-TssExternalVaultSecret [-TssSession] <Session> -Id <Int32> [-Active] [-EnableInheritPermissions]
 [-LinkedSecretId <Int32>] [-Mappings <Object[]>] [-Transform <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set properties of an external vault secret.
Only the parameters passed are changed.
-Mappings replaces the mapping rows of a HashiCorp Vault key/value map binding: rows with an externalVaultSecretMappingId are updated, rows without one are added, and existing rows left out are deleted.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultSecret -TssSession $session -Id 12 -Active:$false
```

Make external vault secret 12 inactive

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultSecret -TssSession $session -Id 12 -Transform '$USERNAME:$PASSWORD'
```

Change the transform of external vault secret 12

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
External vault secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ExternalVaultSecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Make the external vault secret active (-Active) or inactive (-Active:$false)

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

### -Mappings
HashiCorp Vault key/value map bindings only: the full set of mapping rows, each a hashtable with remoteKey, transform and, for an existing row, externalVaultSecretMappingId

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.ExternalVaults.Secret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecret.ps1)
