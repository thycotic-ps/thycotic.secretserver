---
title: New-TssPasswordTypeAuth
parent: Remote Password Changing
grand_parent: Commands
---
# New-TssPasswordTypeAuth

## SYNOPSIS
Add a command credential to a password type

## SYNTAX

```
New-TssPasswordTypeAuth [-TssSession] <Session> -Id <Int32> -CommandTypeCode <Int32> [-Username <String>]
 [-Password <SecureString>] [-Key <String>] [-Passphrase <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add a command credential (password type auth record) to a password type for one command slot.
CommandTypeCode picks the slot: 1 reset password, 2 verify password, 3 reset password by other credentials, 4 post-success commands, 5 post-failure commands.
A password type holds at most one record per slot; the server rejects a duplicate.
Change an existing record with Set-TssPasswordTypeAuth.
There is no REST route to delete a record.
The output is every command credential of that password type, stored secrets included in clear text: handle it as secret material.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$slotPassword = Read-Host -AsSecureString
New-TssPasswordTypeAuth -TssSession $session -Id 9 -CommandTypeCode 3 -Username 'svc-rpc' -Password $slotPassword
```

Add a reset-by-other-credentials slot (code 3) to password type 9 that runs as svc-rpc

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
Type: Int32
Parameter Sets: (All)
Aliases: PasswordTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CommandTypeCode
Command slot, 1 to 5: 1 reset password, 2 verify password, 3 reset password by other credentials, 4 post-success commands, 5 post-failure commands

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

### -Username
Username the command slot runs as

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

### -Password
Password the command slot uses

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
Private key text the command slot uses

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

### -Passphrase
Passphrase of the private key

```yaml
Type: SecureString
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

### Thycotic.PowerShell.Rpc.PasswordTypeAuth[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordTypeAuth](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordTypeAuth)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordTypeAuth.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordTypeAuth.ps1)
