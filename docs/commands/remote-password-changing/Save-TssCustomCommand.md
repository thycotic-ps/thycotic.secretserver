---
title: Save-TssCustomCommand
parent: Remote Password Changing
grand_parent: Commands
---
# Save-TssCustomCommand

## SYNOPSIS
Create, update and delete the custom commands of a password type in one request

## SYNTAX

```
Save-TssCustomCommand [-TssSession] <Session> -Id <Int32> [-Create <Object[]>] [-Update <Object[]>]
 [-DeleteId <Int32[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Saves a batch of changes to the custom commands of an editable password type in a single request: new commands (-Create), changed commands (-Update) and deleted commands (-DeleteId).
Returns the custom commands of the password type after the save.
Use New-TssCustomCommand, Update-TssCustomCommand and Remove-TssCustomCommand for one command at a time.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Save-TssCustomCommand -TssSession $session -Id 18 -Create @{ CommandTypeCode = 1; Command = 'show version'; Comment = 'Log the device version'; Pause = 1000 } -DeleteId 749
```

Add one command to password type 18 and delete command 749 in the same request

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$commands = Search-TssCustomCommand -TssSession $session -Id 18
$commands | ForEach-Object { $_.Pause = 2000 }
Save-TssCustomCommand -TssSession $session -Id 18 -Update $commands
```

Set a two second pause on every command of password type 18

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
ID of the password type whose commands are saved

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PasswordTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Create
Commands to create: objects or hashtables with CommandTypeCode, Command, Comment, Pause (milliseconds) and optionally Order

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Update
Commands to update: objects or hashtables with CustomCommandId, CommandTypeCode, Command, Comment, Order and Pause, for example the output of Search-TssCustomCommand after you changed it

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeleteId
IDs of the custom commands to delete

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Rpc.CustomCommand
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Save-TssCustomCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Save-TssCustomCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Save-TssCustomCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Save-TssCustomCommand.ps1)
