---
title: Search-TssSecretSshRestrictedCommand
parent: Secrets
grand_parent: Commands
---
# Search-TssSecretSshRestrictedCommand

## SYNOPSIS
Get the SSH command restrictions of a secret

## SYNTAX

```
Search-TssSecretSshRestrictedCommand [-TssSession] <Session> -Id <Int32[]> [-AutoCheckIn] [-AutoCheckout]
 [-AutoComment <String>] [-ForceCheckIn] [<CommonParameters>]
```

## DESCRIPTION
Returns the restriction type and the SSH command menus and blocklists that apply to the secret, per group or role.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretSshRestrictedCommand -TssSession $session -Id 42
```

Returns the SSH command restrictions of secret 42

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AutoCheckIn
Check the secret back in after the request completes

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoCheckout
Check out the secret automatically when it requires checkout

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoComment
Comment to record with the automatic checkout, for secrets that require a comment

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

### -ForceCheckIn
Force check in the secret if another user has it checked out

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.SshRestrictedCommand
## NOTES
Requires TssSession object returned by New-TssSession

Requires a Secret Server license that includes SSH command restrictions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretSshRestrictedCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretSshRestrictedCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretSshRestrictedCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretSshRestrictedCommand.ps1)
