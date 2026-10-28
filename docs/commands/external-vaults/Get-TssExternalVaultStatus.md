---
title: Get-TssExternalVaultStatus
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultStatus

## SYNOPSIS
Get the external vault status for the current user

## SYNTAX

```
Get-TssExternalVaultStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the external vault status: the total number of external vaults and whether the current user can create external vault secrets.
TotalVaults counts every external vault on the server, including vaults the current user cannot see.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultStatus -TssSession $session
```

Get the external vault status for the current user

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ExternalVaults.Status
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultStatus.ps1)
