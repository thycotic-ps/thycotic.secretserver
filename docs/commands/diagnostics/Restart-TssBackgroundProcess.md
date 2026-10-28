---
title: Restart-TssBackgroundProcess
parent: Diagnostics
grand_parent: Commands
---
# Restart-TssBackgroundProcess

## SYNOPSIS
Recycle the Secret Server background processes

## SYNTAX

```
Restart-TssBackgroundProcess [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Recycles the background processes (scheduler, remote password changing, heartbeat and the other worker threads) without an IIS reset, the same as the Recycle Background Processes button under Admin, Diagnostics.
Active user sessions are not affected.
Returns an object whose Success property is True when the recycle was started.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Restart-TssBackgroundProcess -TssSession $session
```

Recycle the background processes

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Restart-TssBackgroundProcess -TssSession $session -WhatIf
```

Show what would be sent without recycling anything

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

### Thycotic.PowerShell.Diagnostics.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (Secret Server Cloud answers Access denied).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Restart-TssBackgroundProcess](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Restart-TssBackgroundProcess)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Restart-TssBackgroundProcess.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Restart-TssBackgroundProcess.ps1)
