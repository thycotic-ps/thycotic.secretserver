---
title: Search-TssDualControl
parent: Dual Controls
grand_parent: Commands
---
# Search-TssDualControl

## SYNOPSIS
Search dual controls

## SYNTAX

```
Search-TssDualControl [-TssSession] <Session> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
Returns the active dual controls, or all of them with -IncludeInactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDualControl -TssSession $session -IncludeInactive
```

List all dual controls, active and inactive

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

### -IncludeInactive
Include inactive dual controls

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DualControls.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Search-TssDualControl](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Search-TssDualControl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Search-TssDualControl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Search-TssDualControl.ps1)
