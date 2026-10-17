---
title: Get-TssIncomingDrConfiguration
parent: Disaster Recovery
grand_parent: Commands
---
# Get-TssIncomingDrConfiguration

## SYNOPSIS
Get the Disaster Recovery incoming configuration

## SYNTAX

```
Get-TssIncomingDrConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the Disaster Recovery settings of this Secret Server as a data replica: whether data replication is enabled, the data source URL and public key, the replication interval, the replication status and the last replication time.
A Secret Server that is not a data replica returns DataReplicationEnabled False.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssIncomingDrConfiguration -TssSession $session
```

Get the incoming configuration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssIncomingDrConfiguration -TssSession $session | Select-Object DataReplicationEnabled, ReplicationStatus, LastReplicated
```

Show whether this Secret Server replicates and when it last did

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssIncomingDrConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssIncomingDrConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssIncomingDrConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssIncomingDrConfiguration.ps1)
