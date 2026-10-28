---
title: Set-TssSshCommandMenu
parent: SSH Command Menu
grand_parent: Commands
---
# Set-TssSshCommandMenu

## SYNOPSIS
Change an SSH command menu

## SYNTAX

```
Set-TssSshCommandMenu [-TssSession] <Session> -Id <Int32> [-Active] [-Description <String>] [-Name <String>]
 [-SshCommands <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the SSH command menu with the given ID.
Only the parameters you pass are changed.
-SshCommands replaces the whole menu.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSshCommandMenu -TssSession $session -Id 3 -Active:$false
```

Deactivates the menu with ID 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$menu = Get-TssSshCommandMenu -TssSession $session -Id 3
Set-TssSshCommandMenu -TssSession $session -Id 3 -SshCommands ($menu.SshCommands.TrimEnd() + "`r`nUptime = uptime")
```

Adds one entry to the end of the menu

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
SSH command menu ID (the integer SshCommandMenuId)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SshCommandMenuId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Use -Active to activate the menu or -Active:$false to deactivate it

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

### -Description
New description

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

### -Name
New name

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

### -SshCommands
The new menu entries: "name = command" lines joined with a carriage return and line feed; replaces the whole menu

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

### Thycotic.PowerShell.SshCommandMenu.SshCommandMenu
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Set-TssSshCommandMenu](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Set-TssSshCommandMenu)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Set-TssSshCommandMenu.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Set-TssSshCommandMenu.ps1)
