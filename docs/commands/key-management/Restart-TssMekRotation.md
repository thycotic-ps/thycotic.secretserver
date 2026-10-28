---
title: Restart-TssMekRotation
parent: Key Management
grand_parent: Commands
---
# Restart-TssMekRotation

## SYNOPSIS
Retry a failed master encryption key rotation

## SYNTAX

```
Restart-TssMekRotation [-TssSession] <Session> [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Retries the master encryption key rotation process from its current status, after a step failed.
The server answers even when there is nothing to retry: check CanRetryStatus, ProcessState and ErrorMessage on the output.
Follow progress with Get-TssMekRotationInfo.
This changes how Secret Server encrypts its data: a wrong or interrupted change can leave Secret Server or its secrets unreadable.
The command writes that warning and asks OK to proceed?
before it sends the request.
-Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Restart-TssMekRotation -TssSession $session
```

Retry the master encryption key rotation after a failure

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
if ((Get-TssMekRotationInfo -TssSession $session).CanRetryStatus) { Restart-TssMekRotation -TssSession $session -Confirm:$false }
```

Retry the rotation only when the server allows a retry

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

### Thycotic.PowerShell.KeyManagement.MekRotation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Restart-TssMekRotation](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Restart-TssMekRotation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Restart-TssMekRotation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Restart-TssMekRotation.ps1)
