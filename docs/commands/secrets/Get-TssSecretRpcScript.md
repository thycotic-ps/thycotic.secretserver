---
title: Get-TssSecretRpcScript
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretRpcScript

## SYNOPSIS
Get the remote password changing settings of a secret, with the secrets its RPC scripts may use

## SYNTAX

```
Get-TssSecretRpcScript [-TssSession] <Session> -Id <Int32[]> [-AutoCheckIn] [-AutoCheckout]
 [-AutoComment <String>] [-ForceCheckIn] [<CommonParameters>]
```

## DESCRIPTION
Get the remote password changing (RPC) settings of a secret: auto change and its schedule, the password changer, the privileged account, the current change status and the associated secrets (ResetSecrets) its RPC scripts may use.
Values the server wraps in view fields are returned as plain values.
Replace the associated secrets with Update-TssSecretRpcScript.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretRpcScript -TssSession $session -Id 46
```

Get the RPC settings of secret 46

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSecretRpcScript -TssSession $session -Id 46).ResetSecrets | Select-Object Order, SecretId, SecretName
```

List the associated secrets the RPC scripts of secret 46 may use, in order

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AutoCheckIn
Check the secret in automatically after the request

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

### -AutoCheckout
Check the secret out automatically for the request

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

### -AutoComment
Comment to use for the automatic check-out

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

### -ForceCheckIn
Check the secret in first when another user has it checked out

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.RpcDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretRpcScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretRpcScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretRpcScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretRpcScript.ps1)
