---
title: Get-TssExternalVaultLinkSettings
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultLinkSettings

## SYNOPSIS
Get the settings needed to link an external vault

## SYNTAX

```
Get-TssExternalVaultLinkSettings [-TssSession] <Session> [-CredentialSecretId <Int32>]
 [-HashiCorpEdition <String>] -ExternalVaultType <String> [-SiteId <Int32>]
 [-HashiCorpSkipCertificateValidation] [<CommonParameters>]
```

## DESCRIPTION
Gets the options for linking a new external vault of the given type: the default name, the password types, and the vaults (Azure, AWS, Google) or namespaces and mount points (HashiCorp) reachable with the credential secret.
When the options cannot be read, ActionableErrorMessage says why.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultLinkSettings -TssSession $session -ExternalVaultType AzureKeyVault -CredentialSecretId 42
```

List the Azure key vaults reachable with the credentials in secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultLinkSettings -TssSession $session -ExternalVaultType HashiCorpVault -CredentialSecretId 43 -HashiCorpEdition Enterprise -SiteId 2
```

List the namespaces and mount points of a HashiCorp Vault Enterprise reached through site 2

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

### -CredentialSecretId
Id of the secret that holds the credentials used to read the vault options

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

### -HashiCorpEdition
HashiCorp Vault edition

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

### -ExternalVaultType
Type of external vault to link

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

### -SiteId
Distributed engine site used to reach the vault

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

### -HashiCorpSkipCertificateValidation
Skip TLS certificate validation when reading a HashiCorp Vault

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ExternalVaults.LinkSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultLinkSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultLinkSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultLinkSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultLinkSettings.ps1)
