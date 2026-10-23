---
title: Stop-TssSecretKeyRotation
parent: Configurations
grand_parent: Commands
---
# Stop-TssSecretKeyRotation

## SYNOPSIS
Cancel a running secret key rotation

## SYNTAX

```
Stop-TssSecretKeyRotation [-TssSession] <Session> [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Requests cancellation of the Rotate Secret Keys run in progress and returns the rotation status.
Nothing changes when no rotation is running.
This changes how Secret Server encrypts its data: a wrong or interrupted change can leave Secret Server or its secrets unreadable.
The command writes that warning and asks OK to proceed?
before it sends the request.
-Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Stop-TssSecretKeyRotation -TssSession $session
```

Cancels the secret key rotation in progress

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

### -Force
Skip the OK to proceed?
question, and the confirmation prompt unless -Confirm is passed.
The warning is still written.

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

### Thycotic.PowerShell.Configuration.SecretKeyRotationStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Stop-TssSecretKeyRotation](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Stop-TssSecretKeyRotation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Stop-TssSecretKeyRotation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Stop-TssSecretKeyRotation.ps1)
