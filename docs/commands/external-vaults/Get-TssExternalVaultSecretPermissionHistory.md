---
title: Get-TssExternalVaultSecretPermissionHistory
parent: External Vaults
grand_parent: Commands
---
# Get-TssExternalVaultSecretPermissionHistory

## SYNOPSIS
Get the permission change history of an external vault secret

## SYNTAX

```
Get-TssExternalVaultSecretPermissionHistory [-TssSession] <Session> -Id <Int32[]> -AuditId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Get the permission change history of an external vault secret for one permission change.
Each permission change writes a shared audit entry; -AuditId picks the change and only the records it wrote are returned.
Each record shows a group, the permission it held, who changed it and when, and whether it was removed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssExternalVaultSecretPermissionHistory -TssSession $session -Id 12 -AuditId 1520
```

Get the permission records that the change audited as 1520 wrote for external vault secret 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$change = Search-TssSharedAudit -TssSession $session -AuditType ExternalVaultSecret -ItemId 12 | Where-Object Action -eq 'EDIT PERMISSIONS' | Sort-Object DateRecorded -Descending | Select-Object -First 1
Get-TssExternalVaultSecretPermissionHistory -TssSession $session -Id 12 -AuditId $change.AuditId
```

Get the permission records of the latest permission change on external vault secret 12

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
External vault secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ExternalVaultSecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AuditId
Shared audit ID of the permission change (audit type ExternalVaultSecret, action EDIT PERMISSIONS)

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

### Thycotic.PowerShell.ExternalVaults.SecretPermissionHistory[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretPermissionHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Get-TssExternalVaultSecretPermissionHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretPermissionHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Get-TssExternalVaultSecretPermissionHistory.ps1)
