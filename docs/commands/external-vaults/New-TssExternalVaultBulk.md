---
title: New-TssExternalVaultBulk
parent: External Vaults
grand_parent: Commands
---
# New-TssExternalVaultBulk

## SYNOPSIS
Create several external vaults at once

## SYNTAX

```
New-TssExternalVaultBulk [-TssSession] <Session> -Vault <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates several external vault links in one request.
Each vault definition carries the same fields New-TssExternalVault sends.
Returns one result per vault, with the created vault or the error for that vault.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$vaults = @(@{ name = 'payments-kv'; displayName = 'Payments'; active = $true; credentialSecretId = 42; externalVaultType = 'AzureKeyVault' }, @{ name = 'hr-kv'; displayName = 'HR'; active = $true; credentialSecretId = 42; externalVaultType = 'AzureKeyVault' })
New-TssExternalVaultBulk -TssSession $session -Vault $vaults
```

Create two active Azure Key Vault links that use the credentials in secret 42

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

### -Vault
External vault definitions, one hashtable or object per vault with the keys name, displayName, active, credentialSecretId, externalVaultType (AzureKeyVault, AWSSecretsManager, GoogleSecretManager or HashiCorpVault), optional siteId and, for HashiCorp Vault, hashiCorpConnectionParameters (edition, namespace, mountPoint, kvVersion, skipCertificateValidation)

```yaml
Type: Object[]
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

### Thycotic.PowerShell.ExternalVaults.Bulk
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultBulk](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVaultBulk)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultBulk.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVaultBulk.ps1)
