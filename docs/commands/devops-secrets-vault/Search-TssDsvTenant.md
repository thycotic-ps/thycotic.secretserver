---
title: Search-TssDsvTenant
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Search-TssDsvTenant

## SYNOPSIS
Search DevOps Secrets Vault tenants

## SYNTAX

```
Search-TssDsvTenant [-TssSession] <Session> [-IncludeInactive] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the DevOps Secrets Vault (DSV) tenants, optionally filtered by name.
Inactive tenants are included only with -IncludeInactive.
Requires a DevOps Secrets Vault license.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDsvTenant -TssSession $session
```

List the active DSV tenants

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDsvTenant -TssSession $session -SearchText contoso -IncludeInactive
```

List the DSV tenants whose name matches contoso, inactive included

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
Include inactive tenants

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

### -SearchText
Return tenants whose name matches this text

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

### Thycotic.PowerShell.DevOpsSecretsVault.DsvTenantItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Search-TssDsvTenant](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Search-TssDsvTenant)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Search-TssDsvTenant.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Search-TssDsvTenant.ps1)
