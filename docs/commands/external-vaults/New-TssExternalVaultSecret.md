---
title: New-TssExternalVaultSecret
parent: External Vaults
grand_parent: Commands
---
# New-TssExternalVaultSecret

## SYNOPSIS
Create an external vault secret

## SYNTAX

```
New-TssExternalVaultSecret [-TssSession] <Session> [-Active] -ExternalVaultId <Int32> [-LinkedSecretId <Int32>]
 [-Mappings <Object[]>] -Name <String> [-Transform <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create an external vault secret: a secret in an external vault that Secret Server pushes the value of a linked secret to.
Single mode bindings push the value built by -Transform.
HashiCorp Vault bindings in key/value map mode push one key per -Mappings row.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssExternalVaultSecret -TssSession $session -Name 'sql-prod-sa' -ExternalVaultId 3 -LinkedSecretId 42 -Transform '$PASSWORD' -Active
```

Create an active external vault secret in external vault 3 that pushes the password of secret 42

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
Create the external vault secret as active.
Omitted, it is created inactive

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

### -ExternalVaultId
ID of the external vault that holds the secret

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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
HashiCorp Vault key/value map bindings only: mapping rows, each a hashtable with remoteKey (key in the external vault) and transform (template evaluated at push time), for example @{ remoteKey = 'password'; transform = '$PASSWORD' }

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

### -Name
Name of the secret in the external vault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultSecret.ps1)
