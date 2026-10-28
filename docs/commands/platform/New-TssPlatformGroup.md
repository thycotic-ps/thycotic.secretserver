---
title: New-TssPlatformGroup
parent: Platform
grand_parent: Commands
---
# New-TssPlatformGroup

## SYNOPSIS
Link a Delinea Platform directory group to Secret Server

## SYNTAX

```
New-TssPlatformGroup [-TssSession] <Session> -DomainIdentifier <String> -Name <String> [-GroupType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Links (adds) a directory group from the Delinea Platform to Secret Server, so permissions can be granted to the group before its members log in.
Find the group, its directory identifier and its group type with Search-TssPlatformGroup.
For Active Directory the domain identifier must be in hex format, not GUID format.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssPlatformGroup -TssSession $session -DomainIdentifier '4f2a9c1d8e7b6a5f4f2a9c1d8e7b6a5f' -Name 'Vault Admins' -GroupType Global
```

Links the Vault Admins group from the Platform directory and returns True on success

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformGroup -TssSession $session -SearchText 'Vault' | New-TssPlatformGroup -TssSession $session
```

Links every Platform group whose name starts with Vault (case-sensitive)

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

### -DomainIdentifier
Unique directory identifier of the group.
For Active Directory this is the ADGuid in hex format, not GUID format

```yaml
Type: String
Parameter Sets: (All)
Aliases: DsGuid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Name of the group in the directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupType
Directory group type

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Returns True or False as returned by the server.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformGroup.ps1)
