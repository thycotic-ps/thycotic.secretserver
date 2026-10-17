---
title: Get-TssIpRestrictionConfiguration
parent: IP Address Restrictions
grand_parent: Commands
---
# Get-TssIpRestrictionConfiguration

## SYNOPSIS
Get the IP address restrictions configuration

## SYNTAX

```
Get-TssIpRestrictionConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the global IP address restrictions setting IpAddressSourceType: where Secret Server takes the client IP address that IP address restrictions are checked against.
The value is TrueAddress or HeaderBasedAddress.
In Secret Server Cloud, TrueAddress takes the client IP address from the header set by the cloud infrastructure, and HeaderBasedAddress takes it from a forwarded IP address header, which the client can spoof.
On-premises Secret Server returns the setting but does not use it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssIpRestrictionConfiguration -TssSession $session
```

Returns the IP address restrictions configuration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssIpRestrictionConfiguration -TssSession $session).IpAddressSourceType
```

Returns TrueAddress or HeaderBasedAddress

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

### Thycotic.PowerShell.IpRestrictions.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

Requires permission to administer IP address restrictions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestrictionConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestrictionConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestrictionConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestrictionConfiguration.ps1)
