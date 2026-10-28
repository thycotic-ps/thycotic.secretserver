---
title: Search-TssExternalVaultSecret
parent: External Vaults
grand_parent: Commands
---
# Search-TssExternalVaultSecret

## SYNOPSIS
Search external vault secrets

## SYNTAX

```
Search-TssExternalVaultSecret [-TssSession] <Session> [-ExternalVaultSecretId <Int32[]>]
 [-ExternalVaultId <Int32[]>] [-ExternalVaultType <String[]>] [-LinkedSecretId <Int32>] [-SearchText <String>]
 [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Search the external vault secrets linked to Secret Server secrets.
Filters combine: status, external vault type, external vault, linked secret and external vault secret ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultSecret -TssSession $session -LinkedSecretId 42
```

Get the external vault secrets linked to secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultSecret -TssSession $session -ExternalVaultType HashiCorpVault -Status Active
```

Get the active external vault secrets in HashiCorp Vault external vaults

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

### -ExternalVaultSecretId
Only return these external vault secret IDs

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalVaultId
Only return external vault secrets in these external vaults

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalVaultType
Only return external vault secrets in these external vault types

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkedSecretId
Only return external vault secrets linked to this Secret Server secret

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

### -SearchText
Filter on external vault secret name

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

### -Status
Only return Active or Inactive external vault secrets, or All for both. Without -Status only active external vault secrets are returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ExternalVaults.SecretItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecret.ps1)
