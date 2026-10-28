---
title: Remove-TssJumpboxRouteLevel
parent: Jumpbox Route
grand_parent: Commands
---
# Remove-TssJumpboxRouteLevel

## SYNOPSIS
Remove a level (hop) from a jumpbox route

## SYNTAX

```
Remove-TssJumpboxRouteLevel [-TssSession] <Session> -Id <String> -Order <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the level at the given position from the jumpbox route with the given ID.
The levels after it move up one position, so when removing several levels remove the highest Order first.
Returns True when the level was removed.
Requires the Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 2
```

Removes the second hop from the route

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' | Sort-Object Order | Select-Object -Last 1 | Remove-TssJumpboxRouteLevel -TssSession $session
```

Removes the last hop of the route

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
Jumpbox route ID (a GUID)

```yaml
Type: String
Parameter Sets: (All)
Aliases: JumpboxRouteId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Order
Position of the level on the route, starting at 1

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Remove-TssJumpboxRouteLevel](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Remove-TssJumpboxRouteLevel)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Remove-TssJumpboxRouteLevel.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Remove-TssJumpboxRouteLevel.ps1)
