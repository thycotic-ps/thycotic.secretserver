---
title: Get-TssDataReplication
parent: Disaster Recovery
grand_parent: Commands
---
# Get-TssDataReplication

## SYNOPSIS
Get a Disaster Recovery data replica

## SYNTAX

```
Get-TssDataReplication [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a data replica registered with this Secret Server as a Disaster Recovery data source: name, location, status, replicated folders and the last replication time.
Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration.
An unknown id returns an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0
```

Get one data replica by id

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssOutgoingDrConfiguration -TssSession $session).DataReplicas | Get-TssDataReplication -TssSession $session
```

Get every data replica registered with this Secret Server

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
Data replica id (Guid)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ReplicaId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DisasterRecovery.DataReplication
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDataReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDataReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDataReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDataReplication.ps1)
