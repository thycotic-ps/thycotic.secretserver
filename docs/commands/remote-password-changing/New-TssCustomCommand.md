---
title: New-TssCustomCommand
parent: Remote Password Changing
grand_parent: Commands
---
# New-TssCustomCommand

## SYNOPSIS
Create a custom command on a password type

## SYNTAX

```
New-TssCustomCommand [-TssSession] <Session> -PasswordTypeId <Int32> -CommandTypeCode <Int32> -Command <String>
 [-Comment <String>] [-Order <Int32>] [-Pause <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a custom command to an editable password type (CanEdit True, see Search-TssRpcPasswordType).
Remote Password Changing runs the command for secrets that use the password type.
Returns the new command, including its CustomCommandId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssCustomCommand -TssSession $session -PasswordTypeId 18 -CommandTypeCode 1 -Command 'show version' -Comment 'Log the device version' -Pause 1000
```

Add a command that logs the device version to password type 18, with a one second pause after it

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

### -PasswordTypeId
ID of the editable password type that gets the command

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

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command
Command text to run

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

### -Comment
Comment shown with the command

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

### -Order
Position in the command list.
Omit to add the command at the end

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssCustomCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssCustomCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssCustomCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssCustomCommand.ps1)
