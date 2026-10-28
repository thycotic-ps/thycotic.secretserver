---
title: Get-TssExternalVaultSecretRemoteValue
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultSecretRemoteValue

## SYNOPSIS
Get the value of an external vault secret from the external vault

## SYNTAX

```
Get-TssExternalVaultSecretRemoteValue [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Connect to the external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault) and read the value currently stored there for an external vault secret.
The output carries the secret value in plain text: Value for single mode bindings, Entries for key/value map bindings.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultSecretRemoteValue -TssSession $session -Id 12
```

Get the value stored in the external vault for external vault secret 12

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

### Thycotic.PowerShell.ExternalVaults.SecretRemoteValue
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretRemoteValue](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretRemoteValue)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretRemoteValue.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretRemoteValue.ps1)
