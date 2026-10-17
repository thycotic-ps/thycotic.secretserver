---
title: Get-TssDiscoveryNetworkTree
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryNetworkTree

## SYNOPSIS
Get the Discovery network tree

## SYNTAX

```
Get-TssDiscoveryNetworkTree [-TssSession] <Session> [-DiscoverySourceId <Int32>] [-ParentId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the nodes of the Discovery network tree (discovery sources, domains and organizational units).
Without ParentId the root nodes are returned; a root node has ParentId -1.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryNetworkTree -TssSession $session
```

Get the root nodes of the Discovery network tree

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryNetworkTree -TssSession $session -DiscoverySourceId 1 -ParentId 3
```

Get the children of node 3 in discovery source 1

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

### -DiscoverySourceId
Return only the tree of this discovery source

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

### -ParentId
Return the children of this node

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.NetworkTree[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryNetworkTree](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryNetworkTree)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryNetworkTree.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryNetworkTree.ps1)
