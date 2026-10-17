---
title: Get-TssDiscoverySecretSearchFilter
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySecretSearchFilter

## SYNOPSIS
Get a discovery secret search filter

## SYNTAX

```
Get-TssDiscoverySecretSearchFilter [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a secret search filter by ID.
Discovery scanners use secret search filters to find the secret that holds the credential for a scan.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySecretSearchFilter -TssSession $session -Id 4
```

Get secret search filter 4

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
Secret search filter ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretSearchFilterId

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

### Thycotic.PowerShell.Discovery.SecretSearchFilter
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySecretSearchFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySecretSearchFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySecretSearchFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySecretSearchFilter.ps1)
