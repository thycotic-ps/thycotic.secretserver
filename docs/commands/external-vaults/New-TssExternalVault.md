---
title: New-TssExternalVault
parent: External Vaults
grand_parent: Commands
---
# New-TssExternalVault

## SYNOPSIS
Create an external vault

## SYNTAX

```
New-TssExternalVault [-TssSession] <Session> [-Active] -CredentialSecretId <Int32> [-DisplayName <String>]
 -ExternalVaultType <String> [-HashiCorpEdition <String>] [-HashiCorpKvVersion <Int32>]
 [-HashiCorpMountPoint <String>] [-HashiCorpNamespace <String>] [-HashiCorpSkipCertificateValidation]
 -Name <String> [-SecretRegex <String>] [-SiteId <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an external vault link to Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault.
The credential secret holds the credentials the vault type expects.
Use Get-TssExternalVaultLinkSettings first to list the vaults, namespaces and mount points the credential secret can reach.
For HashiCorp Vault, set the connection with the HashiCorp parameters.
A self-hosted HashiCorp Vault also needs -SiteId.
Use -Active to create the vault active.
Without -Active the vault is created inactive.
Returns the created external vault.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssExternalVault -TssSession $session -Name payments-kv -DisplayName Payments -ExternalVaultType AzureKeyVault -CredentialSecretId 42 -Active
```

Create an active link to the Azure Key Vault payments-kv using the credentials in secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssExternalVault -TssSession $session -Name kv -ExternalVaultType HashiCorpVault -CredentialSecretId 43 -SiteId 2 -HashiCorpEdition Enterprise -HashiCorpNamespace team-a -HashiCorpMountPoint kv -HashiCorpKvVersion 2 -Active
```

Create an active link to the kv mount of a self-hosted HashiCorp Vault Enterprise namespace, reached through site 2

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
Create the external vault active.
Omit to create it inactive

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

Required: True
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

### -ExternalVaultType
Type of the external vault

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

### -HashiCorpEdition
HashiCorp Vault edition (HashiCorp Vault only, default Community)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Community
Accept pipeline input: False
Accept wildcard characters: False
```

### -HashiCorpKvVersion
Version of the HashiCorp KV secrets engine (HashiCorp Vault only, default 2)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -HashiCorpMountPoint
Mount point of the HashiCorp KV secrets engine (HashiCorp Vault only)

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

### -HashiCorpNamespace
HashiCorp Vault namespace (HashiCorp Vault only)

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
Skip TLS certificate validation when connecting to HashiCorp Vault (HashiCorp Vault only)

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

### -Name
Name of the vault in the external system

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
Distributed engine site used to reach the external vault (required for a self-hosted HashiCorp Vault)

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVault](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/New-TssExternalVault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/New-TssExternalVault.ps1)
