---
title: Search-TssCustomCommand
parent: Remote Password Changing
grand_parent: Commands
---
# Search-TssCustomCommand

## SYNOPSIS
List the custom commands of a password type

## SYNTAX

```
Search-TssCustomCommand [-TssSession] <Session> -Id <Int32[]> [-CommandTypeCode <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the custom commands of one or more password types, in command order.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssCustomCommand -TssSession $session -Id 18
```

List the custom commands of password type 18

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRpcPasswordType -TssSession $session | Where-Object Name -like '*Custom (SSH)' | Search-TssCustomCommand -TssSession $session
```

List the custom commands of every custom SSH password type

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
Password type ID whose custom commands are listed

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordTypeId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CommandTypeCode
Only return commands with this command type code (1 password change, 2 verify password, 3 password change with other credentials, 4 after a successful change, 5 after a failed change)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Rpc.CustomCommand[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Search-TssCustomCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Search-TssCustomCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Search-TssCustomCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Search-TssCustomCommand.ps1)
