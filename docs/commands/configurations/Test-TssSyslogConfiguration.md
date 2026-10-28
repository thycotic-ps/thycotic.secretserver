---
title: Test-TssSyslogConfiguration
parent: Configurations
grand_parent: Commands
---
# Test-TssSyslogConfiguration

## SYNOPSIS
Send a test syslog message

## SYNTAX

```
Test-TssSyslogConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Sends a test message to the syslog server configured in Secret Server and returns whether it succeeded, with a description.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssSyslogConfiguration -TssSession $session
```

Sends a test syslog message

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

### Thycotic.PowerShell.Configuration.SyslogTestResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSyslogConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSyslogConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSyslogConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSyslogConfiguration.ps1)
