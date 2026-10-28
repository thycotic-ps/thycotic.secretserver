---
title: New-TssRole
parent: Roles
grand_parent: Commands
---
# New-TssRole

## SYNOPSIS
Create a new role

## SYNTAX

```
New-TssRole [-TssSession] <Session> [-Enabled] -Name <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a role and returns it.
A new role has no permissions.
Add them with Update-TssRolePermission and assign groups with Set-TssRoleGroup.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssRole -TssSession $session -Name "Help Desk" -Enabled
```

Creates an enabled role named Help Desk

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

### -Enabled
Create the role enabled.
Omit to create it disabled

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

### -Name
Name of the new role, unique on the server

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

### Thycotic.PowerShell.Roles.Role
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/New-TssRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/New-TssRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/New-TssRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/New-TssRole.ps1)
