---
title: Get-TssHeartbeatLog
parent: Diagnostics
grand_parent: Commands
---
# Get-TssHeartbeatLog

## SYNOPSIS
Get the heartbeat log

## SYNTAX

```
Get-TssHeartbeatLog [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the heartbeat log shown under Admin, Diagnostics: the heartbeat monitor status messages from the last month.
Secret Server returns the log as comma-separated text.
Each entry becomes one object; text that contains commas or line breaks is kept whole.
CreatedOn is the text the server wrote, in the server culture.
When the server truncates the log it adds a notice, which is written as a warning.
Requires the Administer Configuration or View Configuration permission.
Without the View Remote Password Changing or Administer Remote Password Changing permission the server returns an empty log.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssHeartbeatLog -TssSession $session
```

Get the heartbeat log entries from the last month

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssHeartbeatLog -TssSession $session | Where-Object Text -Match 'fail'
```

Get the heartbeat log entries that mention a failure

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

### Thycotic.PowerShell.Diagnostics.HeartbeatLog
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssHeartbeatLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssHeartbeatLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssHeartbeatLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssHeartbeatLog.ps1)
