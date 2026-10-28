---
title: Get-TssDsvTenantStub
parent: DevOps Secrets Vault
grand_parent: Commands
---
# Get-TssDsvTenantStub

## SYNOPSIS
Get an empty DevOps Secrets Vault tenant

## SYNTAX

```
Get-TssDsvTenantStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets a DevOps Secrets Vault tenant object with default values, the template used to create a tenant.
Requires a DevOps Secrets Vault license.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDsvTenantStub -TssSession $session
```

Get the default values of a new DSV tenant

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DevOpsSecretsVault.DsvTenant
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvTenantStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/devops-secrets-vault/Get-TssDsvTenantStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvTenantStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/devops-secrets-vault/Get-TssDsvTenantStub.ps1)
