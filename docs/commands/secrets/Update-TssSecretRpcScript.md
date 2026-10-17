---
title: Update-TssSecretRpcScript
parent: Secrets
grand_parent: Commands
---
# Update-TssSecretRpcScript

## SYNOPSIS
Replace the associated secrets a secret's RPC scripts may use

## SYNTAX

```
Update-TssSecretRpcScript [-TssSession] <Session> -Id <Int32> -AssociatedSecretId <Int32[]> [-V2]
 [-AutoCheckIn] [-AutoCheckout] [-AutoComment <String>] [-ForceCheckIn]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replace the list of associated secrets (ResetSecrets) that the remote password changing scripts of a secret may use, and return the secret's RPC settings.
The list is replaced, not merged: pass every secret that should stay, in order.
An empty list clears it.
Set-TssSecretRpcAssociated changes the same list through the v1 route and returns only the list; this command uses the v3 route (or the v2 route with -V2) and returns the full RPC settings, as Get-TssSecretRpcScript does.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId 12, 13
```

Let the RPC scripts of secret 46 use secrets 12 and 13, in that order

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$current = (Get-TssSecretRpcScript -TssSession $session -Id 46).ResetSecrets.SecretId
Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId (@($current) + 20)
```

Append secret 20 to the associated secrets of secret 46

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretRpcScript -TssSession $session -Id 46 -AssociatedSecretId @()
```

Clear the associated secrets of secret 46

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AssociatedSecretId
Secret IDs the RPC scripts may use, in order; an empty list clears the list

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -V2
Use the v2 route, for servers without the v3 route

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

### Thycotic.PowerShell.Secrets.RpcDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretRpcScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretRpcScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRpcScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRpcScript.ps1)
