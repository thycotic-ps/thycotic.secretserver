---
title: Set-TssJumpboxRouteLevel
parent: Jumpbox Route
grand_parent: Commands
---
# Set-TssJumpboxRouteLevel

## SYNOPSIS
Change a level (hop) of a jumpbox route

## SYNTAX

```
Set-TssJumpboxRouteLevel [-TssSession] <Session> -Id <String> -Order <Int32> [-NewOrder <Int32>]
 [-Port <Int32>] [-SecretId <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes the position, port or secret of one level of the jumpbox route with the given ID.
Only the parameters you pass are changed.
Requires the Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 1 -Port 2222
```

Changes the port of the first hop to 2222

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 2 -NewOrder 1
```

Moves the second hop to the front of the route

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
Current position of the level on the route, starting at 1

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

### -NewOrder
New position for the level on the route, starting at 1

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

### -Port
New port to connect to for this hop

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

### -SecretId
ID of the new secret whose credentials sign in to this hop

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

### Thycotic.PowerShell.JumpboxRoute.Level
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Set-TssJumpboxRouteLevel](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Set-TssJumpboxRouteLevel)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Set-TssJumpboxRouteLevel.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Set-TssJumpboxRouteLevel.ps1)
