---
title: Set-TssExternalVaultSecretRemoteValue
parent: External Vaults
grand_parent: Commands
---
# Set-TssExternalVaultSecretRemoteValue

## SYNOPSIS
Set the value of an external vault secret in the external vault

## SYNTAX

### Entries
```
Set-TssExternalVaultSecretRemoteValue [-TssSession] <Session> -Id <Int32> -Entries <Hashtable>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Value
```
Set-TssExternalVaultSecretRemoteValue [-TssSession] <Session> -Id <Int32> -Value <SecureString>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Connect to the external vault (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault) and write a value to it for an external vault secret.
Single mode bindings take -Value.
Key/value map bindings take -Entries, one key per configured remote key.
The server rejects the wrong shape for the binding.
The request body is never written to Verbose or WhatIf output.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultSecretRemoteValue -TssSession $session -Id 12 -Value (Read-Host -AsSecureString)
```

Write a new value to the external vault for single mode external vault secret 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newValue = Read-Host -AsSecureString
Set-TssExternalVaultSecretRemoteValue -TssSession $session -Id 13 -Entries @{ username = 'svc-app'; credential = $newValue }
```

Write the username and credential keys to the external vault for key/value map external vault secret 13

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

### -Entries
Key/value pairs to write, for key/value map bindings: each key is a configured remote key, each value a string or SecureString

```yaml
Type: Hashtable
Parameter Sets: Entries
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Value to write, for single mode bindings

```yaml
Type: SecureString
Parameter Sets: Value
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

### Thycotic.PowerShell.ExternalVaults.SecretRemoteValue
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretRemoteValue](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultSecretRemoteValue)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretRemoteValue.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultSecretRemoteValue.ps1)
