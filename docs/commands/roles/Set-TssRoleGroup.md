---
title: Set-TssRoleGroup
parent: Roles
grand_parent: Commands
---
# Set-TssRoleGroup

## SYNOPSIS
Add or remove groups assigned to a role

## SYNTAX

```
Set-TssRoleGroup [-TssSession] <Session> -Id <Int32> [-GroupIdToAdd <Int32[]>] [-GroupIdToRemove <Int32[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds and removes group assignments on a role in one call.
Groups not listed stay as they are.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRoleGroup -TssSession $session -Id 7 -GroupIdToAdd 12, 14 -GroupIdToRemove 9
```

Assigns groups 12 and 14 to role ID 7 and removes group 9

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
Role ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: RoleId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupIdToAdd
IDs of groups to assign to the role

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupIdsToAdd

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupIdToRemove
IDs of groups to remove from the role

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupIdsToRemove

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

### Thycotic.PowerShell.Roles.UpdateResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRoleGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRoleGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRoleGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRoleGroup.ps1)
