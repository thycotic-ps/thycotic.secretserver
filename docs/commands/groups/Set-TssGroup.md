---
title: Set-TssGroup
parent: Groups
grand_parent: Commands
---
# Set-TssGroup

## SYNOPSIS
Update a group

## SYNTAX

```
Set-TssGroup [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Enabled] [-OwnerGroupId <Int32[]>]
 [-AddOwnerGroupId <Int32[]>] [-RemoveOwnerGroupId <Int32[]>] [-IpAddressRestrictionId <Int32[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the name, enabled state, owner groups or IP address restrictions of a group.
Only the parameters you pass are sent; everything else stays as it is.
To change members use Add-TssGroupMember, Remove-TssGroupMember or Set-TssGroupMember.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssGroup -TssSession $session -Id 42 -Name 'Help Desk'
```

Renames group 42 to Help Desk

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssGroup -TssSession $session -Id 42 -Enabled:$false
```

Disables group 42

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssGroup -TssSession $session -Id 42 -AddOwnerGroupId 7
```

Adds group 7 as an owner of group 42

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
Group ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: GroupId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
New name for the group

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

### -Enabled
Enable the group.
Use -Enabled:$false to disable it

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

### -OwnerGroupId
Group IDs that own the group.
Replaces the current owner groups

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddOwnerGroupId
Group IDs to add as owners.
Takes precedence over OwnerGroupId

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveOwnerGroupId
Group IDs to remove as owners.
Takes precedence over OwnerGroupId

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IpAddressRestrictionId
IP address restriction IDs for the group.
Replaces the current restrictions

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Groups.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroup.ps1)
