---
title: Search-TssJumpboxRoute
parent: Jumpbox Route
grand_parent: Commands
---
# Search-TssJumpboxRoute

## SYNOPSIS
Search jumpbox routes

## SYNTAX

```
Search-TssJumpboxRoute [-TssSession] <Session> [-IncludeActive] [-IncludeInactive] [-SearchTerm <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the jumpbox routes that match the filters.
Only active routes are returned unless you pass -IncludeInactive.
Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssJumpboxRoute -TssSession $session -IncludeInactive
```

Returns every jumpbox route, active or not

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ'
```

Returns the active jumpbox routes with "DMZ" in the name

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Search-TssJumpboxRoute](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Search-TssJumpboxRoute)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Search-TssJumpboxRoute.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Search-TssJumpboxRoute.ps1)
