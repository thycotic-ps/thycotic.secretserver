---
title: Get-TssDualControlState
parent: Dual Controls
grand_parent: Commands
---
# Get-TssDualControlState

## SYNOPSIS
Get the dual control state of an item for the current user

## SYNTAX

```
Get-TssDualControlState [-TssSession] <Session> -DualControlType <String> -Id <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
Returns ApprovalRequired when the current user needs an approver to authorize the action on the item, or AccessAllowed when no authorization is needed.
For AllSecretSessions the item ID is not used; pass 0.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDualControlState -TssSession $session -DualControlType Report -Id 21
```

Check whether running report 21 needs a dual control approval

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDualControlState -TssSession $session -DualControlType AllSecretSessions -Id 0
```

Check whether viewing all secret sessions needs a dual control approval

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

### -DualControlType
Type of item: Report, UserAuditReport, Secret, CreateReport or AllSecretSessions

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Item ID (report ID or secret ID); 0 for AllSecretSessions

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DualControls.State
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControlState](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControlState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControlState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControlState.ps1)
