---
title: Get-TssJumpboxRouteLevel
parent: Jumpbox Route
grand_parent: Commands
---
# Get-TssJumpboxRouteLevel

## SYNOPSIS
Get the levels of a jumpbox route

## SYNTAX

```
Get-TssJumpboxRouteLevel [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the levels (hops) of the jumpbox route with the given ID.
Each level names the secret used to sign in to that hop and the port to connect to; Order is the position of the hop on the route, starting at 1.
Secret Server returns at most 20 levels per route.
Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Returns every level of the jumpbox route with the given ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' | Sort-Object Order | Select-Object Order, SecretId, Port
```

Lists the hops of the route in order with the secret and port each one uses

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
Type: String[]
Parameter Sets: (All)
Aliases: JumpboxRouteId

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

### Thycotic.PowerShell.JumpboxRoute.Level[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteLevel](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteLevel)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteLevel.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteLevel.ps1)
