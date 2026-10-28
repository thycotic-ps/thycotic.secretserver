---
title: Get-TssSshCommandMenu
parent: SSH Command Menu
grand_parent: Commands
---
# Get-TssSshCommandMenu

## SYNOPSIS
Get an SSH command menu

## SYNTAX

```
Get-TssSshCommandMenu [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH command menu with the given ID.
A command menu lists the commands a user may pick from when a secret policy limits a proxied SSH session to a menu.
SshCommands holds the menu as one string of "name = command" lines.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandMenu -TssSession $session -Id 3
```

Returns the SSH command menu with ID 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSshCommandMenu -TssSession $session -Id 3).SshCommands -split "`r`n"
```

Lists the "name = command" lines of the menu with ID 3, one per line

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
Type: Int32[]
Parameter Sets: (All)
Aliases: SshCommandMenuId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenu](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenu)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenu.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenu.ps1)
