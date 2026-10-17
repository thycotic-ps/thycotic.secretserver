---
title: Get-TssExternalVaultPermissionHistory
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultPermissionHistory

## SYNOPSIS
Get the permission change history of an external vault

## SYNTAX

```
Get-TssExternalVaultPermissionHistory [-TssSession] <Session> -Id <Int32[]> -AuditId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Get the permission change history of an external vault for one permission change.
Each permission change writes a shared audit entry; -AuditId picks the change and only the records it wrote are returned.
Each record shows a group, the permission it held, who changed it and when, and whether it was removed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultPermissionHistory -TssSession $session -Id 3 -AuditId 1520
```

Get the permission records that the change audited as 1520 wrote for external vault 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$change = Search-TssSharedAudit -TssSession $session -AuditType ExternalVault -ItemId 3 | Where-Object Action -eq 'EDIT PERMISSIONS' | Sort-Object DateRecorded -Descending | Select-Object -First 1
Get-TssExternalVaultPermissionHistory -TssSession $session -Id 3 -AuditId $change.AuditId
```

Get the permission records of the latest permission change on external vault 3

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

### -AuditId
Shared audit ID of the permission change (audit type ExternalVault, action EDIT PERMISSIONS)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ExternalVaults.PermissionHistory[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultPermissionHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultPermissionHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultPermissionHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultPermissionHistory.ps1)
