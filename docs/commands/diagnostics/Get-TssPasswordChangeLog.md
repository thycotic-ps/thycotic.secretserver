---
title: Get-TssPasswordChangeLog
parent: Diagnostics
grand_parent: Commands
---
# Get-TssPasswordChangeLog

## SYNOPSIS
Get the password change log (RPC log)

## SYNTAX

```
Get-TssPasswordChangeLog [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the password change (remote password changing) log shown under Admin, Diagnostics: the status messages the ExpiredSecretMonitor background thread wrote in the last month.
Secret Server returns the log as comma-separated text.
Each entry becomes one object; text that contains commas or line breaks is kept whole.
CreatedOn is the text the server wrote, in the server culture.
When the server truncates the log it adds a notice, which is written as a warning.
An empty log returns nothing.
This is the RPC log shown under Admin, Diagnostics.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordChangeLog -TssSession $session
```

Get the password change (remote password changing) log entries from the last month

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordChangeLog -TssSession $session | Where-Object Text -Match 'error'
```

Get the entries that mention an error

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

### Thycotic.PowerShell.Diagnostics.LogEntry[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssPasswordChangeLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssPasswordChangeLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssPasswordChangeLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssPasswordChangeLog.ps1)
