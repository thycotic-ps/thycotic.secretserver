---
title: Get-TssExternalVaultSecret
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultSecret

## SYNOPSIS
Get an external vault secret

## SYNTAX

```
Get-TssExternalVaultSecret [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get an external vault secret by ID.
An external vault secret links a Secret Server secret to a secret in an external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault).
The output carries the link, the transform or mappings, the last push result and the caller permissions.
It does not carry the secret value; use Get-TssExternalVaultSecretRemoteValue for that.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultSecret -TssSession $session -Id 12
```

Get external vault secret 12

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
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultSecretId

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

### Thycotic.PowerShell.ExternalVaults.Secret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecret.ps1)
