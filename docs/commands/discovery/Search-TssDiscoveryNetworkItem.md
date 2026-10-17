---
title: Search-TssDiscoveryNetworkItem
parent: Discovery
grand_parent: Commands
---
# Search-TssDiscoveryNetworkItem

## SYNOPSIS
Search items found by Discovery

## SYNTAX

```
Search-TssDiscoveryNetworkItem [-TssSession] <Session> [-CreatedEndDate <DateTime>]
 [-CreatedStartDate <DateTime>] [-DiscoveryRuleId <Int32>] [-DiscoverySourceId <Int32>] [-HasComputerAccounts]
 [-ItemType <String>] [-LastPolledEndDate <DateTime>] [-LastPolledStartDate <DateTime>]
 [-LastReachedEndDate <DateTime>] [-LastReachedStartDate <DateTime>] [-Managed] [-OperatingSystem <String>]
 [-OrganizationalUnitId <Int32>] [-ScanItemTemplateId <Int32>] [-SearchChildren] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the computers, accounts, public keys and service accounts found by Discovery and linked in a discovery source and network tree.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryNetworkItem -TssSession $session -DiscoverySourceId 1 -ItemType computer
```

List the computers found by discovery source 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryNetworkItem -TssSession $session -Managed:$false -SearchText svc
```

List unmanaged items whose name contains svc

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

### -CreatedEndDate
If set, used to return results that have a created date less than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedStartDate
If set, used to return results that have a created date greater than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiscoveryRuleId
Filter for items that will be imported by a specific rule

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

### -DiscoverySourceId
Filter by Discovery Source Id

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

### -HasComputerAccounts
Return only items with computer accounts; use -HasComputerAccounts:$false for items without

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemType
Item type: Computer, ComputerAccount, ServiceAccount, PublicKey, DirectoryAccount, EntraIDRole or EntraIDMember.
Omit for every type

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Computer, ComputerAccount, ServiceAccount, PublicKey, DirectoryAccount, EntraIDRole, EntraIDMember

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastPolledEndDate
If set, used to return results that have a last polled date less than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastPolledStartDate
If set, used to return results that have a last polled date greater than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastReachedEndDate
If set, used to return results that have a last reached date less than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastReachedStartDate
If set, used to return results that have a last reached date greater than or equal to the value

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Managed
Return only managed items; use -Managed:$false for unmanaged items.
Omit for both

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OperatingSystem
Operating system to match

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

### -OrganizationalUnitId
Filter by Organizational Unit Id

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

### -ScanItemTemplateId
Filter by scan template id

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

### -SearchChildren
Include every descendant of the organizational unit, not only its direct children

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Text to search for

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

### Thycotic.PowerShell.Discovery.NetworkItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryNetworkItem](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryNetworkItem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryNetworkItem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryNetworkItem.ps1)
