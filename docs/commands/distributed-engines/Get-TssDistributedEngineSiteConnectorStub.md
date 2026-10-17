---
title: Get-TssDistributedEngineSiteConnectorStub
parent: Distributed Engines
grand_parent: Commands
---
# Get-TssDistributedEngineSiteConnectorStub

## SYNOPSIS
Get the default values for a new site connector

## SYNTAX

```
Get-TssDistributedEngineSiteConnectorStub [-TssSession] <Session> -QueueType <String>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a site connector populated with the default values for the given queue type, such as the default port.
Use it as a starting point for New-TssDistributedEngineSiteConnector.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSiteConnectorStub -TssSession $session -QueueType RabbitMq
```

Gets the default values for a new RabbitMQ site connector

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

### -QueueType
Queue type of the new site connector: MemoryMq, RabbitMq, RabbitMqQuorum or AzureServiceBus (cloud only)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.SiteConnector
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorStub.ps1)
