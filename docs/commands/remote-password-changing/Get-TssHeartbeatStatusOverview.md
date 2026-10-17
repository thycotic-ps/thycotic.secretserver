---
title: Get-TssHeartbeatStatusOverview
parent: Remote Password Changing
grand_parent: Commands
---
# Get-TssHeartbeatStatusOverview

## SYNOPSIS
Get the heartbeat status overview

## SYNTAX

```
Get-TssHeartbeatStatusOverview [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the heartbeat dashboard counts: the number of heartbeat-enabled secrets in each heartbeat status, such as Success, Failed or Pending.
Also returns the ids of the heartbeat history, pending and failed reports when the caller can view them, for use with Invoke-TssReport.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssHeartbeatStatusOverview -TssSession $session
```

Get the heartbeat status counts and report ids

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssHeartbeatStatusOverview -TssSession $session).Statuses
```

List the number of secrets in each heartbeat status

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Rpc.HeartbeatStatusOverview
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssHeartbeatStatusOverview](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssHeartbeatStatusOverview)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssHeartbeatStatusOverview.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssHeartbeatStatusOverview.ps1)
