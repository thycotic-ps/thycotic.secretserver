---
title: New-TssJumpboxRoute
parent: Jumpbox Route
grand_parent: Commands
---
# New-TssJumpboxRoute

## SYNOPSIS
Create a jumpbox route

## SYNTAX

```
New-TssJumpboxRoute [-TssSession] <Session> [-Active] [-Description <String>] -Name <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a jumpbox route.
Add its levels (hops) with New-TssJumpboxRouteLevel.
Secret Server has no REST endpoint to delete a jumpbox route; deactivate one with Set-TssJumpboxRoute -Active:$false.
Requires the Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssJumpboxRoute -TssSession $session -Name 'DMZ via bastion' -Description 'Reach DMZ hosts through the bastion' -Active
```

Creates an active jumpbox route

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$route = New-TssJumpboxRoute -TssSession $session -Name 'DMZ via bastion' -Active
New-TssJumpboxRouteLevel -TssSession $session -Id $route.JumpboxRouteId -SecretId 42 -Port 22
```

Creates a route and adds one hop that signs in with secret 42 on port 22

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

### -Active
Create the route as active.
Without -Active the route is created inactive

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

### -Description
Description of the route

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

### -Name
Name of the route

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRoute](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRoute)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRoute.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRoute.ps1)
