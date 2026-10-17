---
title: Invoke-TssDsvSync
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Invoke-TssDsvSync

## SYNOPSIS
Sync secrets to DevOps Secrets Vault now

## SYNTAX

```
Invoke-TssDsvSync [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Queues an immediate sync for one or more DevOps Secrets Vault sync maps.
Each active map is pushed to its DSV tenant; inactive maps are returned unchanged and are not synced.
Takes sync map ids (DevOpsSyncMapId), not secret ids.
The server rejects the request when none of the ids is a sync map.
Returns one sync status per map.
Requires a DevOps Secrets Vault license and an administrator.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDsvSync -TssSession $session -Id 3, 4
```

Queue an immediate sync for sync maps 3 and 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvSyncStatus -TssSession $session -SecretId 42 | Invoke-TssDsvSync -TssSession $session
```

Queue an immediate sync for every active sync map of secret 42

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
Sync map ids to sync now (DevOpsSyncMapId from Add-TssDsvSync or Get-TssDsvSyncStatus)

```yaml
Type: Int32[]
Parameter Sets: (All)
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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvSync[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Invoke-TssDsvSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Invoke-TssDsvSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Invoke-TssDsvSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Invoke-TssDsvSync.ps1)
