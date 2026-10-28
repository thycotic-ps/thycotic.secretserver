---
title: Start-TssHeartbeat
parent: Configurations
grand_parent: Commands
---
# Start-TssHeartbeat

## SYNOPSIS
Run the heartbeat scheduler now

## SYNTAX

```
Start-TssHeartbeat [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Runs the Secret Server heartbeat scheduler now, the same as Run Now on the heartbeat configuration page.
The scheduler processes every pending heartbeat, not a single secret.
To check one secret now, use Start-TssSecretHeartbeat alone: it already runs the check without waiting for the next scheduled run.
Returns True when Secret Server accepted the request.
Heartbeat must be enabled in the Secret Server configuration: while it is off, the request still returns True but no heartbeat runs.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssHeartbeat -TssSession $session
```

Run the heartbeat scheduler now

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssHeartbeat](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssHeartbeat)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssHeartbeat.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssHeartbeat.ps1)
