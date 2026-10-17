---
title: Update-TssIpRestrictionConfiguration
parent: IP Address Restrictions
grand_parent: Commands
---
# Update-TssIpRestrictionConfiguration

## SYNOPSIS
Update the IP address restrictions configuration

## SYNTAX

```
Update-TssIpRestrictionConfiguration [-TssSession] <Session> -IpAddressSourceType <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the global IP address restrictions setting IpAddressSourceType: where Secret Server takes the client IP address that IP address restrictions are checked against.
In Secret Server Cloud, TrueAddress takes the client IP address from the header set by the cloud infrastructure, and HeaderBasedAddress takes it from a forwarded IP address header, which the client can spoof.
Returns the configuration as saved.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssIpRestrictionConfiguration -TssSession $session -IpAddressSourceType TrueAddress
```

Takes the client IP address from the header set by the cloud infrastructure

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$original = Get-TssIpRestrictionConfiguration -TssSession $session
Update-TssIpRestrictionConfiguration -TssSession $session -IpAddressSourceType HeaderBasedAddress
$original | Update-TssIpRestrictionConfiguration -TssSession $session
```

Switches to the forwarded IP address header, then restores the original setting by piping the saved configuration

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

### -IpAddressSourceType
Source of the client IP address: TrueAddress (header set by the Secret Server Cloud infrastructure) or HeaderBasedAddress (forwarded IP address header, which the client can spoof)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.IpRestrictions.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: on-premises Secret Server rejects the update with access denied for every user.
Requires permission to administer IP address restrictions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestrictionConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestrictionConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestrictionConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestrictionConfiguration.ps1)
