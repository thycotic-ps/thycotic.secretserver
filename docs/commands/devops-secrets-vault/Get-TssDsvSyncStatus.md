---
title: Get-TssDsvSyncStatus
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Get-TssDsvSyncStatus

## SYNOPSIS
Get the DevOps Secrets Vault sync status of secrets

## SYNTAX

### filter (Default)
```
Get-TssDsvSyncStatus [-TssSession] <Session> [-IncludeInactive] [-SecretId <Int32>] [-TenantId <Int32>]
 [<CommonParameters>]
```

### id
```
Get-TssDsvSyncStatus [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Without -Id, lists sync maps with their DSV path, status and last sync time, filtered by secret or tenant.
Inactive maps are included only with -IncludeInactive.
With -Id, gets one sync map, including its secret, tenant and next sync time.
Requires a DevOps Secrets Vault license.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvSyncStatus -TssSession $session -SecretId 42
```

List the active sync maps of secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvSyncStatus -TssSession $session -TenantId 1 -IncludeInactive
```

List every sync map that pushes to DSV tenant 1, inactive included

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvSyncStatus -TssSession $session -Id 3
```

Get sync map 3

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

### -IncludeInactive
Include inactive sync maps

```yaml
Type: SwitchParameter
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
Only return sync maps of this secret id

```yaml
Type: Int32
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Only return sync maps that push to this DevOps Secrets Vault tenant id

```yaml
Type: Int32
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Sync map id (DevOpsSyncMapId)

```yaml
Type: Int32[]
Parameter Sets: id
Aliases: DevOpsSyncMapId, SyncMapId

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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvSyncStatus[]
### Thycotic.PowerShell.DevOpsSecretsVault.DsvSync
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvSyncStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvSyncStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvSyncStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvSyncStatus.ps1)
