---
title: Add-TssDsvSync
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Add-TssDsvSync

## SYNOPSIS
Create a sync between a secret and a DevOps Secrets Vault tenant

## SYNTAX

```
Add-TssDsvSync [-TssSession] <Session> [-Active] -DsvTenantId <Int32> [-FieldNamesPath <String[]>]
 -SecretId <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a sync map that pushes a secret to a DevOps Secrets Vault (DSV) tenant at the given DSV path.
Use -Active to create the map active, which also queues an initial sync.
Without -Active the map is created inactive and is not synced until it is activated with Update-TssDsvSync.
Returns the sync status of the new map.
Its DevOpsSyncMapId is the id used by Get-TssDsvSyncStatus, Update-TssDsvSync and Invoke-TssDsvSync.
Requires a DevOps Secrets Vault license and an administrator.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssDsvSync -TssSession $session -SecretId 42 -DsvTenantId 1 -FieldNamesPath apps, billing -Active
```

Push secret 42 to DSV tenant 1 under the path apps/billing and queue the first sync

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssDsvSync -TssSession $session -SecretId 42 -DsvTenantId 1 -FieldNamesPath staging
```

Create an inactive sync map for secret 42 that is not synced until activated

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
Create the sync map active and queue an initial sync.
Omit to create it inactive

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

### -DsvTenantId
Id of the DevOps Secrets Vault tenant the secret is pushed to (see Search-TssDsvTenant)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldNamesPath
Path segments in DevOps Secrets Vault where the secret is stored.
Omit to send an empty path

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
Id of the secret to push to DevOps Secrets Vault

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvSync
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Add-TssDsvSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Add-TssDsvSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Add-TssDsvSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Add-TssDsvSync.ps1)
