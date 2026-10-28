---
title: Set-TssExternalVault
parent: External Vaults
grand_parent: Commands
---
# Set-TssExternalVault

## SYNOPSIS
Update an external vault

## SYNTAX

```
Set-TssExternalVault [-TssSession] <Session> -Id <Int32> [-Active] [-CredentialSecretId <Int32>]
 [-DisplayName <String>] [-HashiCorpSkipCertificateValidation] [-SecretRegex <String>] [-SiteId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing external vault link.
Only the parameters you pass are changed.
The name and type of a vault cannot be changed.
Returns the updated external vault.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVault -TssSession $session -Id 2 -DisplayName Payments -CredentialSecretId 44
```

Rename external vault 2 and point it at the credentials in secret 44

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVault -TssSession $session -Id 3 -HashiCorpSkipCertificateValidation:$false
```

Turn certificate validation back on for HashiCorp Vault link 3

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
External vault id

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

### -Active
Activate the external vault, or pass -Active:$false to deactivate it

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

### -CredentialSecretId
Id of the secret that holds the credentials of the external vault

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

### -DisplayName
Display name of the external vault

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

### -HashiCorpSkipCertificateValidation
Skip TLS certificate validation when connecting to HashiCorp Vault, or pass -HashiCorpSkipCertificateValidation:$false to validate certificates (HashiCorp Vault only)

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

### -SecretRegex
Regular expression that limits which external secrets are listed

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

### -SiteId
Distributed engine site used to reach the external vault

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

### Thycotic.PowerShell.ExternalVaults.ExternalVault
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVault](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVault.ps1)
