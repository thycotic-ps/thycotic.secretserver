---
title: Get-TssDiscoverySourceFilter
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySourceFilter

## SYNOPSIS
Get the OU filters of a discovery source

## SYNTAX

```
Get-TssDiscoverySourceFilter [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the domain scope of an Active Directory discovery source: the organizational units and containers it includes or excludes, with the site, credential secret and scan target of each.
Secret Server reads the domain to answer, so a domain controller must be reachable from the site of the source.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssDiscoverySourceFilter -TssSession $session -Id 3).Filters
```

List the OU filters of discovery source 3

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
Discovery source ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Discovery.SourceFilter
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceFilter.ps1)
