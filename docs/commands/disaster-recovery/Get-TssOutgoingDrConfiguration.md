---
title: Get-TssOutgoingDrConfiguration
parent: Disaster Recovery
grand_parent: Commands
---
# Get-TssOutgoingDrConfiguration

## SYNOPSIS
Get the Disaster Recovery outgoing configuration

## SYNTAX

```
Get-TssOutgoingDrConfiguration [-TssSession] <Session> [-Location <String>] [-Name <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the Disaster Recovery settings of this Secret Server as a data source: the data source URL and public key replicas use, the data package storage path and the registered data replicas.
-Name and -Location filter the data replicas returned in DataReplicas.
A Secret Server with no data replicas returns an empty DataReplicas list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssOutgoingDrConfiguration -TssSession $session
```

Get the outgoing configuration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssOutgoingDrConfiguration -TssSession $session -Name dr).DataReplicas | Select-Object Id, Name, Status, LastReplicated
```

List the data replicas whose name contains dr

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

### -Location
Only return data replicas whose location contains this text

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Only return data replicas whose name contains this text

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.DisasterRecovery.OutgoingDrConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssOutgoingDrConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssOutgoingDrConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssOutgoingDrConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssOutgoingDrConfiguration.ps1)
