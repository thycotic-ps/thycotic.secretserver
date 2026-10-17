---
title: Start-TssSecretKeyRotation
parent: Configurations
grand_parent: Commands
---
# Start-TssSecretKeyRotation

## SYNOPSIS
Start a secret key rotation

## SYNTAX

```
Start-TssSecretKeyRotation [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Requests a Rotate Secret Keys run, which re-encrypts every secret with newly generated keys, and returns the rotation status.
The rotation runs in the background: follow it with Get-TssSecretKeyRotationStatus and cancel it with Stop-TssSecretKeyRotation.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssSecretKeyRotation -TssSession $session -Confirm:$false
```

Starts a secret key rotation without prompting

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

### Thycotic.PowerShell.Configuration.SecretKeyRotationStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssSecretKeyRotation](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssSecretKeyRotation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssSecretKeyRotation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssSecretKeyRotation.ps1)
