---
title: Get-TssSshCommandStub
parent: SSH Command
grand_parent: Commands
---
# Get-TssSshCommandStub

## SYNOPSIS
Get a blank SSH command

## SYNTAX

```
Get-TssSshCommandStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns an SSH command with every field at its default value.
It shows the fields New-TssSshCommand sets.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandStub -TssSession $session
```

Returns a blank SSH command

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SshCommand.SshCommand
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommandStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommandStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommandStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommandStub.ps1)
