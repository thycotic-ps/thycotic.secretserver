---
title: Get-TssIpRestriction
parent: IP Address Restrictions
grand_parent: Commands
---
# Get-TssIpRestriction

## SYNOPSIS
Get an IP address restriction by ID

## SYNTAX

```
Get-TssIpRestriction [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the name and IP range of an IP address restriction.
IP address restrictions limit the IP addresses that the users and groups assigned to them can log in from.
Use Search-TssIpRestriction to list every IP address restriction.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssIpRestriction -TssSession $session -Id 3
```

Returns IP address restriction ID 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssIpRestriction -TssSession $session | Where-Object Name -like 'Office*' | Get-TssIpRestriction -TssSession $session
```

Returns each IP address restriction whose name starts with Office

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
IP address restriction ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: IpAddressRestrictionId

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

### Thycotic.PowerShell.IpRestrictions.IpRestriction
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestriction](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestriction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestriction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestriction.ps1)
