---
title: Set-TssExternalVaultBulk
parent: External Vaults
grand_parent: Commands
---
# Set-TssExternalVaultBulk

## SYNOPSIS
Update several external vaults at once

## SYNTAX

```
Set-TssExternalVaultBulk [-TssSession] <Session> [-Active] [-CredentialSecretId <Int32>]
 [-DisplayName <String>] [-HashiCorpSkipCertificateValidation] [-SecretRegex <String>] [-SiteId <Int32>]
 -Id <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies the same changes to every external vault id passed in one request.
Only the parameters you pass are changed.
Returns one result per vault, with the updated vault or the error for that vault.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultBulk -TssSession $session -Id 2, 3, 4 -Active:$false
```

Deactivate external vaults 2, 3 and 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssExternalVaultBulk -TssSession $session -Id 2, 3 -CredentialSecretId 44 -SiteId 1
```

Point external vaults 2 and 3 at the credentials in secret 44, reached through site 1

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
Activate the external vaults, or pass -Active:$false to deactivate them

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
Id of the secret that holds the credentials of the external vaults

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
Display name of the external vaults

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
Distributed engine site used to reach the external vaults

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

### -Id
Ids of the external vaults to update

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultBulk](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Set-TssExternalVaultBulk)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultBulk.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Set-TssExternalVaultBulk.ps1)
