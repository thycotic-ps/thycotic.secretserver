---
title: Get-TssJumpboxRoute
parent: Jumpbox Route
grand_parent: Commands
---
# Get-TssJumpboxRoute

## SYNOPSIS
Get a jumpbox route

## SYNTAX

```
Get-TssJumpboxRoute [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the jumpbox route with the given ID, including its levels.
A jumpbox route sends a proxied SSH session through one or more intermediate hosts (levels) before it reaches the target.
Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssJumpboxRoute -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Returns the jumpbox route with the given ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ' | Get-TssJumpboxRoute -TssSession $session
```

Returns the full details of every active jumpbox route with "DMZ" in the name

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

### Thycotic.PowerShell.JumpboxRoute.JumpboxRoute
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRoute](https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRoute)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRoute.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRoute.ps1)
