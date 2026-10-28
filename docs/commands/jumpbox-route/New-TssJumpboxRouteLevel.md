---
title: New-TssJumpboxRouteLevel
parent: Jumpbox Route
grand_parent: Commands
---
# New-TssJumpboxRouteLevel

## SYNOPSIS
Add a level (hop) to a jumpbox route

## SYNTAX

```
New-TssJumpboxRouteLevel [-TssSession] <Session> -Id <String> -Port <Int32> -SecretId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a level to the end of the jumpbox route with the given ID.
Each level is one SSH hop: Secret Server signs in to the hop with the credentials of the given secret, on the given port.
Requires the Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -SecretId 42 -Port 22
```

Adds a hop that signs in with secret 42 on port 22 to the end of the route

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ via bastion' | New-TssJumpboxRouteLevel -TssSession $session -SecretId 57 -Port 2222
```

Adds a second hop to the route found by name

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

### -Port
Port to connect to for this hop

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

### -SecretId
ID of the secret whose credentials sign in to this hop

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRouteLevel](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRouteLevel)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRouteLevel.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRouteLevel.ps1)
