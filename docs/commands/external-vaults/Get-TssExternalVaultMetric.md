---
title: Get-TssExternalVaultMetric
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultMetric

## SYNOPSIS
Get metrics for an external vault

## SYNTAX

```
Get-TssExternalVaultMetric [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get metrics for an external vault: the total number of external vault secrets linked to it.
The count includes every external vault secret linked to the vault, including ones the caller cannot see.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultMetric -TssSession $session -Id 3
```

Get the metrics for external vault 3

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
External vault ID

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

### Thycotic.PowerShell.ExternalVaults.Metric
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultMetric](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultMetric)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultMetric.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultMetric.ps1)
