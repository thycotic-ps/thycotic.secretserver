---
title: Search-TssExternalVault
parent: External Vaults
grand_parent: Commands
---
# Search-TssExternalVault

## SYNOPSIS
Search external vaults

## SYNTAX

```
Search-TssExternalVault [-TssSession] <Session> [-ExternalVaultType <String[]>] [-SearchText <String>]
 [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Lists the external vault links the current user can view, optionally filtered by name, type and status.
Without -Status only active vaults are returned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVault -TssSession $session
```

List the active external vaults

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVault -TssSession $session -ExternalVaultType AzureKeyVault, AWSSecretsManager -Status All
```

List every Azure Key Vault and AWS Secrets Manager link, inactive included

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

### -ExternalVaultType
Only return external vaults of these types

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

### -SearchText
Only return external vaults whose name matches this text

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
Return Active (server default), Inactive or All external vaults

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

### Thycotic.PowerShell.ExternalVaults.ExternalVaultItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVault](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVault.ps1)
