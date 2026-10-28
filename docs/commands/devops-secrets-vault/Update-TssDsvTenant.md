---
title: Update-TssDsvTenant
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Update-TssDsvTenant

## SYNOPSIS
Update a DevOps Secrets Vault tenant

## SYNTAX

```
Update-TssDsvTenant [-TssSession] <Session> -Id <Int32> [-Active] -SecretId <Int32> -SyncInterval <Int32>
 -TenantName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing DevOps Secrets Vault tenant.
The server validates the secret, tenant name and sync interval on every update, so all three are required.
Pipe the tenant from Get-TssDsvTenant to keep the values you do not change.
-Active changes the state of the tenant only when it is passed.
The secret must hold the Client ID, Client Secret and Tenant fields of the DevOps Secrets Vault Client Credentials template, and a secret can back only one tenant.
Returns the updated tenant.
Requires a DevOps Secrets Vault license and an administrator.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvTenant -TssSession $session -Id 1 | Update-TssDsvTenant -TssSession $session -SyncInterval 120
```

Change the sync interval of DSV tenant 1 and keep its other settings

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDsvTenant -TssSession $session -Id 1 -TenantName contoso -SecretId 42 -SyncInterval 60 -Active:$false
```

Set every setting of DSV tenant 1 and deactivate it

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
DevOps Secrets Vault tenant id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DsvTenantId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Activate the tenant, or pass -Active:$false to deactivate it

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretId
Id of the secret that holds the DSV client credentials of the tenant

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SyncInterval
Sync interval of the tenant in minutes (at least 10 on-premises, 30 on Secret Server Cloud)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantName
DevOps Secrets Vault tenant name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvTenant](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Update-TssDsvTenant)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvTenant.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Update-TssDsvTenant.ps1)
