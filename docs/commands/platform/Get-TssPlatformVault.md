---
title: Get-TssPlatformVault
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformVault

## SYNOPSIS
Get the Secret Server vaults the Delinea Platform vault broker returns

## SYNTAX

```
Get-TssPlatformVault [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the vaults the Delinea Platform vault broker lists for the session token (GET vaultbroker/api/vaults on the Platform), with the vault id, name, type, default flags, active flag and connection URL.
New-TssSession -PlatformUrl uses the same list to pick the vault: the active vault with -VaultId, else the global default, else the default, else the first active vault.
Requires a session created with New-TssSession -PlatformUrl.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
Get-TssPlatformVault -TssSession $session
```

Lists every vault the Platform vault broker returns for the service user

### EXAMPLE 2
```
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
Get-TssPlatformVault -TssSession $session | Where-Object IsActive | Select-Object VaultId, Name, Url
```

Shows the id, name and URL of each active vault, for use with New-TssSession -VaultId

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession -PlatformUrl for authentication

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

### Thycotic.PowerShell.Platform.Vault
## NOTES
Requires TssSession object returned by New-TssSession -PlatformUrl

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformVault](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformVault)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformVault.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformVault.ps1)
