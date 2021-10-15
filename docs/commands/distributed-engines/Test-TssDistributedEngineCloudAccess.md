# Test-TssDistributedEngineCloudAccess

## SYNOPSIS
Validate network and firewall access to Secret Server Cloud from a device

## SYNTAX

```
Test-TssDistributedEngineCloudAccess [-TssSession] <Session> [-TransportType <Object>] [-Timeout <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Validate network and firewall access to Secret Server Cloud (SSC) from a device.
The command validates port access for SSC and the Azure Service Bus host.
This function would be used from your Distributed Engine to verify the proper outputbound access is in place for a Distributed Engine to communicate with SSC.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
Test-TssDistributedEngineCloudAccess -TssSession $session -TransportType AMQP -Timeout 30
```

Run Hostname and IP port test for SSC URL and Service Bus with ports 5671 and 5672 for AMQP, with a timeout of 30 seconds

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.eu -Credential $ssCred
Test-TssDistributedEngineCloudAccess -TssSession $session
```

Run Hostname and IP port test for SSC URL and Service Bus with port 443 (Web Sockets), with a default timeout of 5 seconds

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

### -TransportType
Azure ServiceBus Transport Type (Admin \> Distributed Engine \> Configuration tab), defaults to WebSockets

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Web Sockets
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
Timeout for connection test, defaults to 5 seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.CloudAccessResult
## NOTES
Requires TssSession object returned by New-TssSession

Details on IP and Hostnames used:
    - https://docs.thycotic.com/ss/11.0.0/secret-server-setup/upgrading/ssc-ip-change-3-21#new_ip_addresses_and_hostnames
    - https://docs.thycotic.com/ss-arc/1.0.0/secret-server/secret-server-cloud

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineCloudAccess](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineCloudAccess)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineCloudAccess.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineCloudAccess.ps1)

