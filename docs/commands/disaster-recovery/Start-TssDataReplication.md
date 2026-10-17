---
title: Start-TssDataReplication
parent: Disaster Recovery
grand_parent: Commands
---
# Start-TssDataReplication

## SYNOPSIS
Start Disaster Recovery data replication now

## SYNTAX

```
Start-TssDataReplication [-TssSession] <Session> [-DataSince <DateTime>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Runs data replication now on this Secret Server when it is a Disaster Recovery data replica, instead of waiting for the replication interval.
With -DataSince only changes made after that time are replicated.
The output Success and Message properties say whether replication was queued; when data replication is not enabled Success is False.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDataReplication -TssSession $session
```

Start data replication now

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDataReplication -TssSession $session -DataSince (Get-Date).AddDays(-1)
```

Replicate only the changes made in the last day

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

### -DataSince
Only replicate changes made after this date and time.
Sent to the server in UTC

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Start-TssDataReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Start-TssDataReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Start-TssDataReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Start-TssDataReplication.ps1)
