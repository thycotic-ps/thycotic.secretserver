---
title: Test-TssDataReplication
parent: Disaster Recovery
grand_parent: Commands
---
# Test-TssDataReplication

## SYNOPSIS
Test the Disaster Recovery data replication connection

## SYNTAX

```
Test-TssDataReplication [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Tests the connection from this Secret Server (a Disaster Recovery data replica) to its configured data source.
The output Success and Message properties give the result.
When data replication is not enabled the server returns an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssDataReplication -TssSession $session
```

Test the connection to the data source

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$result = Test-TssDataReplication -TssSession $session
if (-not $result.Success) { $result.Message }
```

Show the failure message when the connection test fails

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

### Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Test-TssDataReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Test-TssDataReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Test-TssDataReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Test-TssDataReplication.ps1)
