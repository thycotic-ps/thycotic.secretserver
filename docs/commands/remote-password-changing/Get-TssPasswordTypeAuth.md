---
title: Get-TssPasswordTypeAuth
parent: Remote Password Changing
grand_parent: Commands
---
# Get-TssPasswordTypeAuth

## SYNOPSIS
Get the command credentials of a password type

## SYNTAX

```
Get-TssPasswordTypeAuth [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the command credentials (password type auth records) stored on a password type.
Each record is one command slot (CommandTypeCode 1 to 5) with the username, password, key and passphrase the password changer uses for that slot.
The output carries those stored credentials in clear text: handle it as secret material.
Only SSH password types with custom commands hold command credentials; other password types return Access Denied.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordTypeAuth -TssSession $session -Id 9
```

Get the command credential records of password type 9

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRpcPasswordType -TssSession $session -SearchText 'SSH' | Where-Object HasCommands | Get-TssPasswordTypeAuth -TssSession $session | Select-Object Id, PasswordTypeId, CommandTypeCode, Username
```

List the command slots of the SSH password types that have custom commands, without showing the stored secrets

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
Password type ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Rpc.PasswordTypeAuth[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeAuth](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeAuth)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeAuth.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeAuth.ps1)
