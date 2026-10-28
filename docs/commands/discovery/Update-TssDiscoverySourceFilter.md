---
title: Update-TssDiscoverySourceFilter
parent: Discovery
grand_parent: Commands
---
# Update-TssDiscoverySourceFilter

## SYNOPSIS
Replace the OU filters of a discovery source

## SYNTAX

```
Update-TssDiscoverySourceFilter [-TssSession] <Session> -Id <Int32> -Filter <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the domain scope of an Active Directory discovery source: the organizational units and containers it includes or excludes.
Filters not given are removed; pass an empty array to remove them all.
Each filter needs Guid, FilterType (Include or Exclude) and ScanTargetType (Users, Computers or UsersAndComputers), and may carry DiscoveryFilterId, SiteId and SecretId.
The Filters of Get-TssDiscoverySourceFilter can be changed and passed back.
Secret Server reads the domain to apply the filters, so a domain controller must be reachable from the site of the source.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$scope = Get-TssDiscoverySourceFilter -TssSession $session -Id 3
Update-TssDiscoverySourceFilter -TssSession $session -Id 3 -Filter ($scope.Filters | Where-Object DisplayName -NE 'Test')
```

Remove the filter named Test from discovery source 3 and keep the others

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$ou = Get-TssDiscoverySourceOu -TssSession $session -Id 3 -SearchText 'Servers' -Include | Select-Object -First 1
Update-TssDiscoverySourceFilter -TssSession $session -Id 3 -Filter @{ Guid = $ou.Guid; FilterType = 'Include'; ScanTargetType = 'Computers' }
```

Scope discovery source 3 to the computers in the first OU whose name contains Servers

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
Type: Int32
Parameter Sets: (All)
Aliases: DiscoverySourceId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter
Filters to set, as objects or hashtables with the properties named in the description

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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

### Thycotic.PowerShell.Discovery.SourceFilter
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceFilter.ps1)
