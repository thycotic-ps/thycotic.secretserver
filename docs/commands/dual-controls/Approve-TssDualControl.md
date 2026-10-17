---
title: Approve-TssDualControl
parent: Dual Controls
grand_parent: Commands
---
# Approve-TssDualControl

## SYNOPSIS
Authorize a dual control as an approver

## SYNTAX

```
Approve-TssDualControl [-TssSession] <Session> -DualControlType <String> -Id <Int32> -Credential <PSCredential>
 [-DomainId <Int32>] [-TwoFactorToken <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
The approver authorizes the action on the given item by entering their own credentials; the result says whether the authorization succeeded.
The approver must be a member of an approval group of the dual control and another user than the one signed in to the session; otherwise the server answers API_DualControlAuthFailed.
The request body carries the approver password and is never written to the verbose stream or the ShouldProcess message.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$approver = Get-Credential
Approve-TssDualControl -TssSession $session -DualControlType Report -Id 21 -Credential $approver
```

Authorize running report 21 as the approver in $approver

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Approve-TssDualControl -TssSession $session -DualControlType AllSecretSessions -Id 0 -Credential $approver -DomainId 1 -TwoFactorToken 123456
```

Authorize viewing all secret sessions as a domain approver with a two-factor token

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

### -Credential
Credential of the approver (a member of one of the approval groups)

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainId
Domain ID of the approver, for a domain account; omit for a local account

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

### -TwoFactorToken
Two-factor token of the approver, when the approver has two-factor authentication

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

### Thycotic.PowerShell.DualControls.AuthResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Approve-TssDualControl](https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Approve-TssDualControl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Approve-TssDualControl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Approve-TssDualControl.ps1)
