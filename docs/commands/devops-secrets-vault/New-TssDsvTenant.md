---
title: New-TssDsvTenant
parent: DevOps Secrets Vault
grand_parent: Commands
---
# New-TssDsvTenant

## SYNOPSIS
Create a DevOps Secrets Vault tenant

## SYNTAX

```
New-TssDsvTenant [-TssSession] <Session> [-Active] -SecretId <Int32> -SyncInterval <Int32> -TenantName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a DevOps Secrets Vault (DSV) tenant that ties a secret holding DSV client credentials to a DSV tenant name and a sync interval.
Secrets are then pushed to the tenant with Add-TssDsvSync.
Use -Active to create the tenant active.
Without -Active the tenant is created inactive.
The secret must hold the Client ID, Client Secret and Tenant fields of the DevOps Secrets Vault Client Credentials template, and a secret can back only one tenant.
Returns the created tenant.
Requires a DevOps Secrets Vault license and an administrator.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDsvTenant -TssSession $session -TenantName contoso -SecretId 42 -SyncInterval 60 -Active
```

Create an active DSV tenant contoso whose client credentials are in secret 42

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
Create the tenant active.
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

### -SecretId
Id of the secret that holds the DSV client credentials of the tenant

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

### -SyncInterval
Sync interval of the tenant in minutes (at least 10 on-premises, 30 on Secret Server Cloud)

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

### -TenantName
DevOps Secrets Vault tenant name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/New-TssDsvTenant](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/New-TssDsvTenant)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/New-TssDsvTenant.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/New-TssDsvTenant.ps1)
