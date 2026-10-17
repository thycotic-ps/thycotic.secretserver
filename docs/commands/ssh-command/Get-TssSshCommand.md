---
title: Get-TssSshCommand
parent: SSH Command
grand_parent: Commands
---
# Get-TssSshCommand

## SYNOPSIS
Get an SSH command

## SYNTAX

```
Get-TssSshCommand [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SSH command with the given ID.
SSH commands are the allowed and blocked command lines that SSH command menus and SSH command blocklists use to control what a user can run in a proxied SSH session.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommand -TssSession $session -Id 12
```

Returns the SSH command with ID 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked | Get-TssSshCommand -TssSession $session
```

Returns every blocked SSH command

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
SSH command ID (the integer SshCommandId)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SshCommandId

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

### Thycotic.PowerShell.SshCommand.SshCommand
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommand.ps1)
