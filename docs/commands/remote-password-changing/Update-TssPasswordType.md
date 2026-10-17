---
title: Update-TssPasswordType
parent: Remote Password Changing
grand_parent: Commands
---
# Update-TssPasswordType

## SYNOPSIS
Update a custom password type

## SYNTAX

### object (Default)
```
Update-TssPasswordType [-TssSession] <Session> -PasswordType <PasswordType[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### field
```
Update-TssPasswordType [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Active] [-CustomPort <Int32>]
 [-LineEnding <String>] [-UseUsernameAndPassword] [-IgnoreSSL] [-UseSSL] [-ValidForTakeover] [-RequestTerminal]
 [-RunnerType <String>] [-ExitCommand <String>] [-WindowsCustomPorts <String>] [-OdbcConnectionString <String>]
 [-MainframeConnectionString <String>] [-RpcScriptId <Int32>] [-RpcScriptArgs <String>]
 [-HeartbeatScriptId <Int32>] [-HeartbeatScriptArgs <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a password type.
The server does not block changes to built-in password types that are not editable (CanEdit False): check CanEdit with Get-TssRpcPasswordType before you update by ID.
By ID (-Id with field parameters): changes only the fields you pass; every other field stays as it is.
By object (-PasswordType, or a password type piped in with no field parameters): replaces the whole password type with the object, typically the output of Get-TssRpcPasswordType after you changed its properties.
The server resets any field it does not receive, so this parameter set only takes a complete password type object and refuses one with no Name or with CanEdit False.
Script and LDAP settings IDs of 0 are sent as none.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssPasswordType -TssSession $session -Id 79 -CustomPort 2222 -LineEnding CarriageReturnNewLine
```

Change only the port and the line ending of password type 79

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$type = Get-TssRpcPasswordType -TssSession $session -Id 79
$type.ExitCommand = 'exit'
$type | Update-TssPasswordType -TssSession $session
```

Replace password type 79 with its current settings plus a new exit command

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
ID of the password type to update

```yaml
Type: Int32
Parameter Sets: field
Aliases: PasswordTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Password type name

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Make the password type active (-Active) or inactive (-Active:$false)

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomPort
Custom network port, -1 for the default port

```yaml
Type: Int32
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LineEnding
Line ending sent after each command

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseUsernameAndPassword
Whether the password type uses both the username and the password

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreSSL
Whether certificate errors are ignored

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Whether the connection uses SSL

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidForTakeover
Whether the password type is valid for account takeover

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestTerminal
Whether an SSH pseudo terminal is requested

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunnerType
Password changer runner type

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExitCommand
Command sent to end the session

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WindowsCustomPorts
Custom ports for Windows password changers

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OdbcConnectionString
ODBC connection string

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MainframeConnectionString
Mainframe connection string

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpcScriptId
ID of the script that changes the password

```yaml
Type: Int32
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpcScriptArgs
Arguments of the password change script

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatScriptId
ID of the script that runs heartbeat

```yaml
Type: Int32
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatScriptArgs
Arguments of the heartbeat script

```yaml
Type: String
Parameter Sets: field
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordType
Complete password type object, as returned by Get-TssRpcPasswordType

```yaml
Type: PasswordType[]
Parameter Sets: object
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

### Thycotic.PowerShell.Rpc.PasswordType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssPasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssPasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssPasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssPasswordType.ps1)
