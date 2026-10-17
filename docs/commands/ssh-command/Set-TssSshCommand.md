---
title: Set-TssSshCommand
parent: SSH Command
grand_parent: Commands
---
# Set-TssSshCommand

## SYNOPSIS
Change an SSH command

## SYNTAX

```
Set-TssSshCommand [-TssSession] <Session> -Id <String> [-Command <String>] [-Name <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the name or command text of the SSH command with the given GUID.
Only the parameters you pass are changed.
The permission type (Allowed or Blocked) cannot be changed.
Requires the Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSshCommand -TssSession $session -Id '9d47e2b1-5c03-4f8e-b6a2-1e7c0d93a4f5' -Command 'ls -lah'
```

Changes the command text

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommand -TssSession $session -Id 12 | Set-TssSshCommand -TssSession $session -Name 'List all files'
```

Renames the SSH command with ID 12

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
SSH command GUID (SshCommandGuid), not the integer SshCommandId

```yaml
Type: String
Parameter Sets: (All)
Aliases: SshCommandGuid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Command
New command line text

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
New display name

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

### Thycotic.PowerShell.SshCommand.SshCommand
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Set-TssSshCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Set-TssSshCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Set-TssSshCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Set-TssSshCommand.ps1)
