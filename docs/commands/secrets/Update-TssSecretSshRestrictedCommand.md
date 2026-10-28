---
title: Update-TssSecretSshRestrictedCommand
parent: Secrets
grand_parent: Commands
---
# Update-TssSecretSshRestrictedCommand

## SYNOPSIS
Update the SSH command restrictions of a secret

## SYNTAX

```
Update-TssSecretSshRestrictedCommand [-TssSession] <Session> -Id <Int32> [-AutoCheckIn] [-AutoCheckout]
 [-AutoComment <String>] [-ForceCheckIn] [-AllowOwnersUnrestrictedCommands] [-CommandRestrictionType <String>]
 [-RestrictSshCommands] [-SshCommandBlocklist <Object[]>] [-SshCommandMenu <Object[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the SSH command restrictions of a secret, including whether commands are restricted, the restriction type, and the menus or blocklists that apply.
A switch left out is turned off and a CommandRestrictionType left out resets to AllowedMenu; menus and blocklists left out are kept.
Returns True on success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretSshRestrictedCommand -TssSession $session -Id 42 -RestrictSshCommands -CommandRestrictionType AllowedMenu -SshCommandMenu @{ sshCommandMenuId = 3; groupId = 15 }
```

Limits group 15 to command menu 3 on secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretSshRestrictedCommand -TssSession $session -Id 42 -RestrictSshCommands:$false -AllowOwnersUnrestrictedCommands
```

Removes the SSH command restrictions from secret 42.
Without -AllowOwnersUnrestrictedCommands or a command menu Secret Server rejects the call

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
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

### -AllowOwnersUnrestrictedCommands
Let secret owners run any command

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

### -CommandRestrictionType
AllowedMenu limits users to command menus; BlockedList blocks the commands in blocklists

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

### -RestrictSshCommands
Restrict the SSH commands users can run on the secret.
To remove the restrictions pass -RestrictSshCommands:$false with -AllowOwnersUnrestrictedCommands; Secret Server applies the AllowedMenu rule even when restrictions are off

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshCommandBlocklist
Blocklists per role, one hashtable each: @{ sshCommandBlocklistId = \<guid\>; rolePermissionId = \<id\> }

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

### -SshCommandMenu
Command menus per group, one hashtable each: @{ sshCommandMenuId = \<id\>; groupId = \<id\> }

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Requires a Secret Server license that includes SSH command restrictions.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretSshRestrictedCommand](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretSshRestrictedCommand)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretSshRestrictedCommand.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretSshRestrictedCommand.ps1)
