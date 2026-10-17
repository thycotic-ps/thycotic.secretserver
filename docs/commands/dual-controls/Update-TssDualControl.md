---
title: Update-TssDualControl
parent: Dual Controls
grand_parent: Commands
---
# Update-TssDualControl

## SYNOPSIS
Update a dual control

## SYNTAX

```
Update-TssDualControl [-TssSession] <Session> -Id <Int32> [-DualControlTypeId <Int32>] [-ItemId <Int32>]
 [-ApprovalGroupId <Int32[]>] [-Active] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
The server replaces the whole dual control, so the cmdlet first reads the current dual control (Get-TssDualControl) and changes only the parameters you pass; a failed read stops the cmdlet before any change.
-ApprovalGroupId replaces the complete list of approval groups.
Activating a dual control needs at least one approval group.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDualControl -TssSession $session -Id 3 -Active:$false
```

Deactivate dual control 3 and keep its approval groups

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDualControl -TssSession $session -Id 3 -ApprovalGroupId 4, 9 -Active
```

Make groups 4 and 9 the approvers of dual control 3 and activate it

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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DualControlTypeId
New dual control type ID, from Search-TssDualControlType

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

### -ItemId
New protected item ID (report ID or secret ID)

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
IDs of the groups whose members can approve; replaces the current list

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Activate the dual control; -Active:$false deactivates it

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Update-TssDualControl](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Update-TssDualControl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Update-TssDualControl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Update-TssDualControl.ps1)
