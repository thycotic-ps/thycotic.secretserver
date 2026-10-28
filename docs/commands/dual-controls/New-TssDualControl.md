---
title: New-TssDualControl
parent: Dual Controls
grand_parent: Commands
---
# New-TssDualControl

## SYNOPSIS
Create a dual control

## SYNTAX

```
New-TssDualControl [-TssSession] <Session> -DualControlTypeId <Int32> [-ItemId <Int32>]
 -ApprovalGroupId <Int32[]> [-Active] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
Creates a dual control of the given type with the groups whose members can approve.
Types that protect one item (a report or a secret) need -ItemId; All Secrets Session Access protects all items and takes no -ItemId.
Get the type IDs from Search-TssDualControlType.
The dual control is created inactive unless -Active is passed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDualControl -TssSession $session -DualControlTypeId 1 -ItemId 21 -ApprovalGroupId 4 -Active
```

Require a member of group 4 to approve each run of report 21

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$type = Search-TssDualControlType -TssSession $session | Where-Object Name -eq 'All Secrets Session Access'
New-TssDualControl -TssSession $session -DualControlTypeId $type.Id -ApprovalGroupId 4, 7 -Active
```

Require a member of group 4 or 7 to approve viewing all secret sessions

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

### -DualControlTypeId
Dual control type ID, from Search-TssDualControlType

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

### -ItemId
ID of the protected item (report ID or secret ID); omit for All Secrets Session Access

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

### -ApprovalGroupId
IDs of the groups whose members can approve

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Create the dual control active

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

### Thycotic.PowerShell.DualControls.DualControl
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/New-TssDualControl](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/New-TssDualControl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/New-TssDualControl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/New-TssDualControl.ps1)
