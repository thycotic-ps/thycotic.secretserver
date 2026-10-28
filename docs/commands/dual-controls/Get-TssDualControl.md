---
title: Get-TssDualControl
parent: Dual Controls
grand_parent: Commands
---
# Get-TssDualControl

## SYNOPSIS
Get a dual control by ID

## SYNTAX

```
Get-TssDualControl [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
Returns the dual control with its type, item and approval groups.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDualControl -TssSession $session -Id 3
```

Get dual control 3

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
Dual control ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.DualControls.DualControl
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControl](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControl.ps1)
