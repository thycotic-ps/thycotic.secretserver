---
title: Update-TssCustomCommand
parent: Remote Password Changing
grand_parent: Commands
---
# Update-TssCustomCommand

## SYNOPSIS
Update a custom command

## SYNTAX

```
Update-TssCustomCommand [-TssSession] <Session> -Id <Int32> -PasswordTypeId <Int32> [-CommandTypeCode <Int32>]
 [-Command <String>] [-Comment <String>] [-Order <Int32>] [-Pause <Int32>] [-ConcurrencyId <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a custom command of an editable password type.
The server replaces the whole command, so any of -CommandTypeCode, -Command, -Comment, -Order, -Pause and -ConcurrencyId you do not pass is copied from the current command (read with Search-TssCustomCommand, one extra request).
Piping the output of Search-TssCustomCommand binds every field, so no extra request is made.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssCustomCommand -TssSession $session -Id 749 -PasswordTypeId 18 -Comment 'Log the device version before the change'
```

Change only the comment of custom command 749 of password type 18

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssCustomCommand -TssSession $session -Id 18 | Where-Object Command -eq 'show version' | Update-TssCustomCommand -TssSession $session -Pause 2000
```

Set a two second pause on the matching commands of password type 18

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
ID of the custom command to update

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: CustomCommandId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PasswordTypeId
ID of the password type the command belongs to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CommandTypeCode
Command type code: 1 password change, 2 verify password (heartbeat), 3 password change with other credentials, 4 after a successful change, 5 after a failed change

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Command
Command text to run

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Comment
Comment shown with the command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Order
Position in the command list

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Pause
Pause after the command runs, in milliseconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConcurrencyId
Concurrency ID of the command, as returned by Search-TssCustomCommand

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssCustomCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssCustomCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssCustomCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssCustomCommand.ps1)
