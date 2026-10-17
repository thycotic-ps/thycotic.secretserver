---
title: New-TssDiscoverySource
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoverySource

## SYNOPSIS
Create a discovery source

## SYNTAX

### Default (Default)
```
New-TssDiscoverySource [-TssSession] <Session> -DiscoverySourceType <String> -Name <String> -SiteId <Int32>
 [-SecretId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ActiveDirectory
```
New-TssDiscoverySource [-TssSession] <Session> -Name <String> -SiteId <Int32> -SecretId <Int32>
 [-ActiveDirectory] [-Active] [-DiscoverSpecificOUs] [-MachineNameResolutionType <String>]
 [-FullyQualifiedDomainName <String>] [-FriendlyName <String>] [-UseSecureLdap]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a discovery source with no scanners.
Add scanners with Add-TssDiscoverySourceScanner.
With -ActiveDirectory, creates an Active Directory discovery source for a domain instead, using the domain settings given.
An Active Directory source is created active unless -Active:$false is given.
Secret Server always creates the domain as an Active Directory domain with the user principal name import format.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoverySource -TssSession $session -Name 'Linux servers' -DiscoverySourceType Unix -SiteId 1
```

Create a Unix discovery source run by site 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoverySource -TssSession $session -ActiveDirectory -Name 'Corp domain' -FullyQualifiedDomainName corp.example.com -FriendlyName CORP -SecretId 42 -SiteId 1
```

Create an Active Directory discovery source for corp.example.com that scans with secret 42

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

### -DiscoverySourceType
Type of discovery source to create

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Discovery source name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
ID of the site that runs the scanners of the source (Get-TssSite)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
ID of the secret used as the default discovery credential of the source; required with -ActiveDirectory

```yaml
Type: Int32
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: ActiveDirectory
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActiveDirectory
Create an Active Directory discovery source

```yaml
Type: SwitchParameter
Parameter Sets: ActiveDirectory
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Create the Active Directory source active (default true)

```yaml
Type: SwitchParameter
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiscoverSpecificOUs
Only discover the OUs in the filter of the source

```yaml
Type: SwitchParameter
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MachineNameResolutionType
How discovered machines are named: UseMachineNameAndFQDM or OnlyUseMachineName

```yaml
Type: String
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FullyQualifiedDomainName
Fully qualified name of the domain, for example corp.example.com

```yaml
Type: String
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FriendlyName
Display name of the domain

```yaml
Type: String
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSecureLdap
Connect to the domain with LDAPS

```yaml
Type: SwitchParameter
Parameter Sets: ActiveDirectory
Aliases:

Required: False
Position: Named
Default value: False
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

### Thycotic.PowerShell.Discovery.Source
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySource](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySource.ps1)
