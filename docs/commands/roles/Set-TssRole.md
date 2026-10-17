---
title: Set-TssRole
parent: Roles
grand_parent: Commands
---
# Set-TssRole

## SYNOPSIS
Update the name or enabled state of a role

## SYNTAX

```
Set-TssRole [-TssSession] <Session> -Id <Int32> [-Enabled] [-Name <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the name or enabled state of a role and returns the updated role.
Only the parameters you pass are sent.
Omitted values stay unchanged.
Use -Enabled:$false to disable a role.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRole -TssSession $session -Id 7 -Enabled:$false
```

Disables role ID 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRole -TssSession $session -Id 7 -Name "Help Desk Tier 2"
```

Renames role ID 7 to Help Desk Tier 2

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

### -Enabled
Enable the role.
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

### -Name
New name for the role

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

### Thycotic.PowerShell.Roles.Role
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRole.ps1)
