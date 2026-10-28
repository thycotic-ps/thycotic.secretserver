---
title: New-TssSshCommand
parent: SSH Command
grand_parent: Commands
---
# New-TssSshCommand

## SYNOPSIS
Create an SSH command

## SYNTAX

```
New-TssSshCommand [-TssSession] <Session> -Command <String> [-CommandPermissionType <String>] -Name <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an SSH command: a named command line marked Allowed or Blocked.
Allowed commands go into SSH command menus; blocked commands go into SSH command blocklists.
Secret Server has no REST endpoint to delete an SSH command.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSshCommand -TssSession $session -Name 'List files' -Command 'ls -la'
```

Creates an allowed SSH command

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSshCommand -TssSession $session -Name 'Reboot' -Command 'reboot' -CommandPermissionType Blocked
```

Creates a blocked SSH command, ready to add to a blocklist

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

### -Command
Command line text, unique within its permission type

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

### -CommandPermissionType
Allowed (the default) or Blocked

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
Display name of the command, unique within its permission type

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

### Thycotic.PowerShell.SshCommand.SshCommand
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/New-TssSshCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/New-TssSshCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/New-TssSshCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/New-TssSshCommand.ps1)
