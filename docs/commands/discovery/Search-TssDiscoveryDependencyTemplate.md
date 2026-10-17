---
title: Search-TssDiscoveryDependencyTemplate
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryDependencyTemplate

## SYNOPSIS
Search Discovery dependency templates

## SYNTAX

```
Search-TssDiscoveryDependencyTemplate [-TssSession] <Session> [-SecretDependencyTypeId <Int32>]
 [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Discovery dependency templates, which map a dependency type (for example a Windows service or IIS application pool) to a scan template.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryDependencyTemplate -TssSession $session
```

List the active dependency templates

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryDependencyTemplate -TssSession $session -Status All -SecretDependencyTypeId 1
```

List active and inactive dependency templates of dependency type 1

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

### -SecretDependencyTypeId
Return only templates of this dependency type

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Active, Inactive or All.
The server returns active templates when omitted

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

### Thycotic.PowerShell.Discovery.DependencyTemplateSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryDependencyTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryDependencyTemplate.ps1)
