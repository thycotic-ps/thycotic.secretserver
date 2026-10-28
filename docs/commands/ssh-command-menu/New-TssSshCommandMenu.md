---
title: New-TssSshCommandMenu
parent: SSH Command Menu
grand_parent: Commands
---
# New-TssSshCommandMenu

## SYNOPSIS
Create an SSH command menu

## SYNTAX

```
New-TssSshCommandMenu [-TssSession] <Session> [-Active] -Description <String> -Name <String>
 -SshCommands <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an SSH command menu.
SshCommands is one string of "name = command" lines separated by a carriage return and line feed.
Secret Server has no REST endpoint to delete a menu; deactivate one with Set-TssSshCommandMenu -Active:$false.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSshCommandMenu -TssSession $session -Name 'Linux basics' -Description 'Read-only commands' -SshCommands ('List files = ls -la', 'Disk usage = df -h' -join "`r`n") -Active
```

Creates an active menu with two commands

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

### -Active
Create the menu as active.
Without -Active the menu is created inactive

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
Description of the menu

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

### -Name
Name of the menu

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

### -SshCommands
The menu entries: "name = command" lines joined with a carriage return and line feed

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

### Thycotic.PowerShell.SshCommandMenu.SshCommandMenu
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/New-TssSshCommandMenu](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/New-TssSshCommandMenu)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/New-TssSshCommandMenu.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/New-TssSshCommandMenu.ps1)
