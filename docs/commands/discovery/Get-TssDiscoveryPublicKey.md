---
title: Get-TssDiscoveryPublicKey
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryPublicKey

## SYNOPSIS
Get a discovered public key

## SYNTAX

```
Get-TssDiscoveryPublicKey [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more SSH public keys found by Discovery, including the key, the computer it was found on and the secret it is linked to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryPublicKey -TssSession $session -Id 314
```

Get the detail of discovered public key 314

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
Network item id of the public key

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: NetworkItemId

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

### Thycotic.PowerShell.Discovery.DiscoveryPublicKey
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryPublicKey](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryPublicKey)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryPublicKey.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryPublicKey.ps1)
