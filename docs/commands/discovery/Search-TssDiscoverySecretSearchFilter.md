---
title: Search-TssDiscoverySecretSearchFilter
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoverySecretSearchFilter

## SYNOPSIS
Search discovery secret search filters

## SYNTAX

```
Search-TssDiscoverySecretSearchFilter [-TssSession] <Session> [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists discovery secret search filters.
Returns active filters unless -Status is given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoverySecretSearchFilter -TssSession $session
```

List the active secret search filters

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoverySecretSearchFilter -TssSession $session -Status All
```

List all secret search filters

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

### -Status
Return Active, Inactive or All filters

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

### Thycotic.PowerShell.Discovery.SecretSearchFilter[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySecretSearchFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySecretSearchFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySecretSearchFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySecretSearchFilter.ps1)
