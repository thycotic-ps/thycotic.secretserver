---
title: Update-TssGroupRole
parent: Groups
grand_parent: Commands
---
# Update-TssGroupRole

## SYNOPSIS
Replace all roles of a group

## SYNTAX

```
Update-TssGroupRole [-TssSession] <Session> -Id <Int32> -RoleId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the roles of a group to exactly the roles given.
Roles the group has that are not in RoleId are removed.
Use Add-TssGroupRole to add roles without removing any.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssGroupRole -TssSession $session -Id 42 -RoleId 3
```

Makes role 3 the only role of group 42

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

### -RoleId
Role IDs the group should have.
Roles not listed are removed

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Groups.RoleChangeStatus
## NOTES
Requires TssSession object returned by New-TssSession

Uses the v2 roles endpoint, available from Secret Server 11.5.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroupRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroupRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroupRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroupRole.ps1)
