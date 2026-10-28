---
title: Test-TssDistributedEngineSiteConnectivity
parent: Distributed Engines
grand_parent: Commands
---
# Test-TssDistributedEngineSiteConnectivity

## SYNOPSIS
Test the round trip from Secret Server to the engines of a site

## SYNTAX

```
Test-TssDistributedEngineSiteConnectivity [-TssSession] <Session> -Id <Int32> [-Timeout <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Sends a test message through the site connector to the engines of a site and waits for the reply.
Returns ValidationSuccess and a ValidationMessage with the round-trip times or the failure reason.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssDistributedEngineSiteConnectivity -TssSession $session -Id 3
```

Tests the connectivity of site 3 with the default 30 second timeout

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssDistributedEngineSiteConnectivity -TssSession $session -Id 3 -Timeout 120
```

Tests the connectivity of site 3, waiting up to two minutes

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
Site ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SiteId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout
Seconds to wait for the round trip, 1 to 3600 (default 30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.SiteConnectivity
## NOTES
Requires TssSession object returned by New-TssSession

A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint without the site segment (distributed-engine/{siteId}/validate-connectivity), so the request fails.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnectivity](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnectivity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnectivity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnectivity.ps1)
