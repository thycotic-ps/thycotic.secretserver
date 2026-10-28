---
title: Update-TssSecretJumpboxRouteSelection
parent: Secret Hooks
grand_parent: Commands
---
# Update-TssSecretJumpboxRouteSelection

## SYNOPSIS
Set or clear the jumpbox route of a secret

## SYNTAX

### route (Default)
```
Update-TssSecretJumpboxRouteSelection [-TssSession] <Session> -Id <Int32> -JumpboxRouteId <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### clear
```
Update-TssSecretJumpboxRouteSelection [-TssSession] <Session> -Id <Int32> [-Clear]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Assigns a jumpbox route to a secret, or clears the assignment with -Clear.
Returns the assigned route; nothing when cleared.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretJumpboxRouteSelection -TssSession $session -Id 42 -JumpboxRouteId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Assigns the jumpbox route to secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretJumpboxRouteSelection -TssSession $session -Id 42 -Clear
```

Clears the jumpbox route of secret 42

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

### -JumpboxRouteId
ID (GUID) of the jumpbox route to assign

```yaml
Type: String
Parameter Sets: route
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear
Clear the jumpbox route assignment of the secret

```yaml
Type: SwitchParameter
Parameter Sets: clear
Aliases:

Required: True
Position: Named
Default value: False
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

### Thycotic.PowerShell.SecretHooks.JumpboxRouteSelection
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Update-TssSecretJumpboxRouteSelection](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Update-TssSecretJumpboxRouteSelection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Update-TssSecretJumpboxRouteSelection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Update-TssSecretJumpboxRouteSelection.ps1)
