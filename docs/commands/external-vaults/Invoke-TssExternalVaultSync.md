---
title: Invoke-TssExternalVaultSync
parent: External Vaults
grand_parent: Commands
---
# Invoke-TssExternalVaultSync

## SYNOPSIS
Push, pull or sync external vault secrets

## SYNTAX

```
Invoke-TssExternalVaultSync [-TssSession] <Session> -Action <String> [-ExternalVaultId <Int32[]>]
 [-ExternalVaultSecretId <Int32[]>] [-LinkedSecretId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Push secret values from Secret Server to external vaults, pull external vault secrets into Secret Server, or both (Sync).
-ExternalVaultId supports Push, Pull and Sync for every active external vault secret in those vaults.
-ExternalVaultSecretId and -LinkedSecretId only act on Push.
The output lists the push results and the pull results, each with the external vault secret or vault, or the error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssExternalVaultSync -TssSession $session -Action Sync -ExternalVaultId 3
```

Pull and push every active external vault secret in external vault 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssExternalVaultSync -TssSession $session -Action Push -LinkedSecretId 42
```

Push the value of secret 42 to every external vault secret linked to it

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

### -Action
Push (Secret Server to external vault), Pull (external vault to Secret Server) or Sync (both)

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

### -ExternalVaultId
External vaults to push, pull or sync

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalVaultSecretId
External vault secrets to push (Push only)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkedSecretId
Push every external vault secret linked to this Secret Server secret (Push only)

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

### Thycotic.PowerShell.ExternalVaults.Sync
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Invoke-TssExternalVaultSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Invoke-TssExternalVaultSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Invoke-TssExternalVaultSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Invoke-TssExternalVaultSync.ps1)
