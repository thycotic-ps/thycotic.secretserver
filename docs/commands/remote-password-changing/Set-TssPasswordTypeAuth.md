---
title: Set-TssPasswordTypeAuth
parent: Remote Password Changing
grand_parent: Commands
---
# Set-TssPasswordTypeAuth

## SYNOPSIS
Update a command credential of a password type

## SYNTAX

```
Set-TssPasswordTypeAuth [-TssSession] <Session> -Id <Int32> [-Username <String>] [-Password <SecureString>]
 [-Key <String>] [-Passphrase <SecureString>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update one existing command credential (password type auth record) of a password type.
Only the values you pass are changed; the others keep their stored value.
The output is every command credential of that password type, stored secrets included in clear text: handle it as secret material.
Use New-TssPasswordTypeAuth to add a record for a command slot that has none.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newPassword = Read-Host -AsSecureString
Set-TssPasswordTypeAuth -TssSession $session -Id 3 -Username 'svc-rpc' -Password $newPassword
```

Set the username and password of password type auth record 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordTypeAuth -TssSession $session -Id 9 | Where-Object CommandTypeCode -eq 2 | Set-TssPasswordTypeAuth -TssSession $session -Username 'verify-user'
```

Change the username of the verify-password command slot (code 2) of password type 9

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
Password type auth ID (the Id property of Get-TssPasswordTypeAuth output), not the password type ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PasswordTypeAuthId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssPasswordTypeAuth](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssPasswordTypeAuth)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssPasswordTypeAuth.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssPasswordTypeAuth.ps1)
