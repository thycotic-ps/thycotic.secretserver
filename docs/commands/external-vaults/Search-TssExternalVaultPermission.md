---
title: Search-TssExternalVaultPermission
parent: External Vaults
grand_parent: Commands
---
# Search-TssExternalVaultPermission

## SYNOPSIS
Search the permissions of an external vault

## SYNTAX

```
Search-TssExternalVaultPermission [-TssSession] <Session> -Id <Int32[]> [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the user and group permissions on an external vault.
Each record shows the user or group and the external vault permissions it holds.
Edit the records and pass them to Update-TssExternalVaultPermission to change them.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultPermission -TssSession $session -Id 3
```

Get all permissions on external vault 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssExternalVaultPermission -TssSession $session -Id 3 -SearchText 'Vault Admins'
```

Get the permissions on external vault 3 for users or groups matching Vault Admins

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

### -SearchText
Filter on user or group name

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

### Thycotic.PowerShell.ExternalVaults.Permission[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultPermission.ps1)
