---
title: Get-TssExternalVault
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVault

## SYNOPSIS
Get an external vault

## SYNTAX

```
Get-TssExternalVault [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets an external vault link (Azure Key Vault, AWS Secrets Manager, Google Secret Manager or HashiCorp Vault): its type, credential secret, distributed engine site, secret name filter, last pull date and the permissions of the current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVault -TssSession $session -Id 2
```

Get external vault 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVault -TssSession $session -ExternalVaultType HashiCorpVault | Get-TssExternalVault -TssSession $session
```

Get every active HashiCorp Vault link

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
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultId

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

### Thycotic.PowerShell.ExternalVaults.ExternalVault
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVault](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVault.ps1)
