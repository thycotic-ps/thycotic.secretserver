---
title: Test-TssEventLog
parent: Diagnostics
grand_parent: Commands
---
# Test-TssEventLog

## SYNOPSIS
Write a test entry to the Secret Server event log

## SYNTAX

```
Test-TssEventLog [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Asks Secret Server to write a test entry to the Windows event log of the web server, to check that event log writing works.
Returns True when the entry was written.
When the web server cannot write to the event log (for example, the application pool identity may not create the Secret Server event source), the error Secret Server returns is written as an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssEventLog -TssSession $session
```

Write a test entry to the event log and return True when it worked

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Test-TssEventLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Test-TssEventLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Test-TssEventLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Test-TssEventLog.ps1)
