---
title: Update-TssDsvSync
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Update-TssDsvSync

## SYNOPSIS
Update a sync between a secret and a DevOps Secrets Vault tenant

## SYNTAX

```
Update-TssDsvSync [-TssSession] <Session> -Id <Int32> [-Active] [-DsvTenantId <Int32>]
 [-FieldNamesPath <String[]>] [-SecretId <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates an existing DevOps Secrets Vault sync map.
Only the parameters you pass are changed.
Returns the sync status of the updated map.
Requires a DevOps Secrets Vault license and an administrator.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDsvSync -TssSession $session -Id 3 -Active:$false
```

Deactivate sync map 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDsvSync -TssSession $session -Id 3 -FieldNamesPath apps, billing, prod
```

Move the DSV path of sync map 3 to apps/billing/prod

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
Sync map id (DevOpsSyncMapId)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DevOpsSyncMapId, SyncMapId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Activate the sync map, or pass -Active:$false to deactivate it

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
Id of the DevOps Secrets Vault tenant the secret is pushed to

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

### -FieldNamesPath
Path segments in DevOps Secrets Vault where the secret is stored

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
Id of the secret the sync map pushes

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvSync.ps1)
