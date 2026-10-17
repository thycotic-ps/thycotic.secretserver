---
title: Search-TssDsvTenantAudit
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Search-TssDsvTenantAudit

## SYNOPSIS
Search DevOps Secrets Vault tenant audits

## SYNTAX

```
Search-TssDsvTenantAudit [-TssSession] <Session> [-SearchText <String>] [-TenantId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the audit trail of changes made to DevOps Secrets Vault tenants, optionally filtered by tenant or text.
Requires a DevOps Secrets Vault license.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDsvTenantAudit -TssSession $session -TenantId 1
```

List the audit trail of DSV tenant 1

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

### -SearchText
Only return audits matching this text

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

### -TenantId
Only return audits of this DevOps Secrets Vault tenant id

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DevOpsSecretsVault.DsvTenantAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Search-TssDsvTenantAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Search-TssDsvTenantAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Search-TssDsvTenantAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Search-TssDsvTenantAudit.ps1)
