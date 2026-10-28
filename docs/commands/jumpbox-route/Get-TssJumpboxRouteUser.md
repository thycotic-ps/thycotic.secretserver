---
title: Get-TssJumpboxRouteUser
parent: Jumpbox Route
grand_parent: Commands
---
# Get-TssJumpboxRouteUser

## SYNOPSIS
Get the jumpbox routes available to the current user

## SYNTAX

```
Get-TssJumpboxRouteUser [-TssSession] <Session> [-IncludeActive] [-IncludeInactive] [-SearchTerm <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the jumpbox routes the signed-in user can pick when launching a proxied SSH session.
Unlike Search-TssJumpboxRoute it needs no role permission.
The result includes a row with an empty JumpboxRouteId that stands for connecting without a jumpbox route.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRouteUser -TssSession $session
```

Returns the active jumpbox routes the signed-in user can use

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRouteUser -TssSession $session -SearchTerm 'DMZ' -IncludeInactive
```

Returns the active and inactive routes with "DMZ" in the name that the signed-in user can use

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

### -IncludeActive
Include active routes.
Active routes are included by default; use -IncludeActive:$false to leave them out

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

### -IncludeInactive
Include inactive routes.
Defaults to on when you pass -IncludeActive:$false, off otherwise

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

### -SearchTerm
Return only routes whose name matches this text

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteUser.ps1)
