---
title: Start-TssConfigurationRpc
parent: Configurations
grand_parent: Commands
---
# Start-TssConfigurationRpc

## SYNOPSIS
Run Remote Password Changing now

## SYNTAX

```
Start-TssConfigurationRpc [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts the Remote Password Changing (RPC) scheduler immediately, so every pending password change is processed now instead of at the next RPC interval.
This acts on all secrets with a pending password change, not on one secret.
To change the password of one secret use Start-TssSecretChangePassword.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssConfigurationRpc -TssSession $session
```

Process all pending password changes now

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

### Thycotic.PowerShell.Configuration.RpcRunNowResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationRpc](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationRpc)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationRpc.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationRpc.ps1)
